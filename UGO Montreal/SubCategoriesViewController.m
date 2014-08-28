//
//  SubCategoriesViewController.m
//  UGO Montreal
//
//  Created by Julien Saad on 2014-08-05.
//  Copyright (c) 2014 Développements Third Bridge Inc. All rights reserved.
//

#import "SubCategoriesViewController.h"
#import "AFNetworking.h"
#import "ParallaxPhotoViewController.h"
#import "UIImage+animatedGIF.h"

typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown,
    ScrollDirectionCrazy,
} ScrollDirection;

@interface SubCategoriesViewController ()

@property UIImageView* imv;
@property (nonatomic, assign) CGFloat lastContentOffset;

@end

@implementation SubCategoriesViewController
int currentVenue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.screenName = @"Persona Screen";
    self.navigationItem.title = _tagName;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    _scrollView.delegate = self;
    self.view.backgroundColor = UIColorFromRGB(UGO_LIGHTGRAY);
    _venuesAndPersonas = [[NSMutableArray alloc] init];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    NSDictionary *parameters = @{@"id": _tagId};
    
    [manager POST:[NSString stringWithFormat:@"%@/getVenuesAndPersonasFromTag",REQUEST_URL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"JSON: %@", responseObject);
        
        for(NSDictionary* d in responseObject){
            Persona* p = [[Persona alloc]init];
            p.personaDescription = ISFRENCH?[d objectForKey:@"description_fr"]:[d objectForKey:@"description"];

            p.personaId = [d objectForKey:@"id"];
            p.name = ISFRENCH?[d objectForKey:@"name_fr"]:[d objectForKey:@"name"];
           
            
            for(NSDictionary* t in [d objectForKey:@"venues"]){
                Venue* v = [[Venue alloc] init];
                
                @try {
                    v.shortDesc = ISFRENCH?[t objectForKey:@"short_desc_fr"]:[t objectForKey:@"short_desc_en"];
                }
                @catch (NSException *exception) {
                    v.shortDesc = ISFRENCH?[t objectForKey:@"description_fr"]:[t objectForKey:@"description_en"];
                }
                @finally {
                    
                }
                
                [v setBestTime:[t objectForKey:@"best_time"]];
                [v setPriceText:[t objectForKey:@"price"]];
                v.descriptionEn = ISFRENCH?[t objectForKey:@"description_fr"]:[t objectForKey:@"description_en"];
                v.fbUrl = [t objectForKey:@"facebook_url"];
                v.icono = [[t objectForKey:@"iconography"] intValue];
                v.location = [t objectForKey:@"location"];
                v.price = [[t objectForKey:@"price"] intValue];
                v.type = [[t objectForKey:@"type"] intValue];
                v.phoneNumber = [t objectForKey:@"phone"];
                v.name = [t objectForKey:@"name"];
                v.venueId = [t objectForKey:@"id"];
                v.color = UIColorFromRGB([[t objectForKey:@"color"] intValue]);
                v.personaId = p.personaId;
                v.imgUrls = [[NSMutableArray alloc] init];
                for(NSDictionary* im in [t objectForKey:@"images"]){
                    [v.imgUrls addObject:[im objectForKey:@"url"]];
                }
             
                if([_tagType intValue] == v.type)
                    [p.venues addObject:v];
            }
            
            if(p.venues.count>0)
                [_venuesAndPersonas addObject:p];
        }
        
        [self generateScroll];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)generateScroll{
    
    int currentY = 10;
    for(Persona* pers in _venuesAndPersonas){
        PersonaCard * p = [[PersonaCard alloc] initWithNumberOfVenues:pers.venues.count andY:currentY];
        [self.scrollView addSubview:p];
        
        [p setPersona:pers andSelector:@selector(nextPage:) andSender:self];
        
        currentY+= p.frame.size.height;
        currentY+= 10; // cards padding
        
        
    }
    
    UIImageView* foot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"full"]];

    
    _imv =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"full"]];
    _imv.hidden = YES;
    NSString *path=[[NSBundle mainBundle]pathForResource:@"animation" ofType:@"gif"];
    NSURL *url=[[NSURL alloc] initFileURLWithPath:path];
    UIImage * testImage = [UIImage animatedImageWithAnimatedGIFURL:url];
    _imv.animationImages = testImage.images;
    _imv.animationDuration = testImage.duration;
    _imv.image= [UIImage animatedImageWithAnimatedGIFURL:url].images.lastObject;
    _imv.animationRepeatCount = 1;
    _imv.frame = CGRectMake(20, yScreenHeight-_imv.frame.size.height-58, _imv.frame.size.width*0.9, _imv.frame.size.height*0.9);
    
    foot.frame = _imv.frame;
    
    [self.view addSubview:foot];
    [self.view addSubview:_imv];

    [self.view bringSubviewToFront:self.scrollView];

    int padding = 70;
    
    if(currentY<yScreenHeight)
        padding = yScreenHeight-currentY;
    [self.scrollView setContentSize:CGSizeMake(yScreenWidth, currentY+padding-60)];

}



-(void)nextPage:(id)sender{
    currentVenue = [sender tag];
    [self performSegueWithIdentifier:@"DescriptionSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    Venue* nextVenue;
    for(Persona*pers in _venuesAndPersonas){
        for(Venue* v in pers.venues){
            if([v.venueId intValue]==currentVenue){
                nextVenue = v;
            }
        }
    }
    
    [(ParallaxPhotoViewController*)segue.destinationViewController setVenue:nextVenue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    ScrollDirection scrollDirection = ScrollDirectionUp;
    if (self.lastContentOffset > scrollView.contentOffset.y)
        scrollDirection = ScrollDirectionUp;
    else if (self.lastContentOffset < scrollView.contentOffset.y)
        scrollDirection = ScrollDirectionDown;
    
    self.lastContentOffset = scrollView.contentOffset.y;
    
    
    float scrollViewHeight = scrollView.frame.size.height;
    float scrollContentSizeHeight = scrollView.contentSize.height;
    float scrollOffset = scrollView.contentOffset.y;
    
    
    if (scrollOffset + scrollViewHeight >= scrollContentSizeHeight+70)
    {
        if(!_imv.isAnimating && scrollDirection == ScrollDirectionDown){
            [_imv startAnimating];
            _imv.hidden = NO;
        }
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
