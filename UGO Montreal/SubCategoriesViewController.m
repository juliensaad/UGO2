//
//  SubCategoriesViewController.m
//  UGO Montreal
//
//  Created by Julien Saad on 2014-08-05.
//  Copyright (c) 2014 Développements Third Bridge Inc. All rights reserved.
//

#import "SubCategoriesViewController.h"
#import "AFNetworking.h"

@interface SubCategoriesViewController ()

@end

@implementation SubCategoriesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    self.view.backgroundColor = UIColorFromRGB(UGO_LIGHTGRAY);
    _venuesAndPersonas = [[NSMutableArray alloc] init];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    NSDictionary *parameters = @{@"id": @"156"};
    
    [manager POST:@"http://127.0.0.1:8888/ugo_dev_2/index.php/appservice/getVenuesAndPersonasFromTag" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        for(NSDictionary* d in responseObject){
            Persona* p = [[Persona alloc]init];
            p.personaDescription = [d objectForKey:@"description"];
            p.personaDescriptionFr = [d objectForKey:@"description_fr"];
            p.personaId = [d objectForKey:@"id"];
            p.name = [d objectForKey:@"name"];
            p.personaNameFr = [d objectForKey:@"name_fr"];
            
            for(NSDictionary* t in [d objectForKey:@"venues"]){
                Venue* v = [[Venue alloc] init];
                v.bestTime = [t objectForKey:@"best_time"];
                v.descriptionEn = [t objectForKey:@"description_en"];
                v.descriptionFr = [t objectForKey:@"description_fr"];
                v.fbUrl = [t objectForKey:@"facebook_url"];
                v.icono = [[t objectForKey:@"iconography"] intValue];
                v.location = [t objectForKey:@"location"];
                v.price = [[t objectForKey:@"price"] intValue];
                v.type = [[t objectForKey:@"type"] intValue];
                v.phoneNumber = [t objectForKey:@"phone"];
                v.name = [t objectForKey:@"name"];

                [p.venues addObject:v];
            }
            
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
        [self.view addSubview:p];
        
        [p setPersona:pers];
        
        currentY+= p.frame.size.height;
        currentY+= 10; // cards padding
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
