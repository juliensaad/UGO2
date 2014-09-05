//
//  SampleScrollViewController.m
//  QMBParallaxScrollView-Sample
//
//  Created by Toni Möckel on 02.11.13.
//  Copyright (c) 2013 Toni Möckel. All rights reserved.
//

#import "VenueViewController.h"
#import "AFNetworking.h"
#import "Animations.h"
#import <BlurryModalSegue.h>


@interface VenueViewController ()

@property CGRect initialFrame;
@property CGRect favouriteButtonSize;
@property BOOL venueLiked;
@end

@implementation VenueViewController

-(NSString *)getUniqueDeviceIdentifierAsString
{
    
    NSString *appName=[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    
    NSString *strApplicationUUID = [SSKeychain passwordForService:appName account:@"incoding"];
    if (strApplicationUUID == nil)
    {
        strApplicationUUID  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [SSKeychain setPassword:strApplicationUUID forService:appName account:@"incoding"];
    }
    return strApplicationUUID;
}

- (IBAction)favouriteClick:(id)sender {
    
    [Animations animateWithPopAndRotation:_favouriteButton fromSize:_favouriteButtonSize toSize:_venueLiked?40.0f:60.0f andNewImage:[UIImage imageNamed:_venueLiked?@"fav-btn.png":@"favourite-full.png"]];
    _venueLiked = !_venueLiked;

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    NSDictionary *parameters = @{@"user_id": [self getUniqueDeviceIdentifierAsString],
                                 @"venue_id":_venue.venueId};

    [manager POST:[NSString stringWithFormat:@"%@/%@",REQUEST_URL, _venueLiked?@"addFavourite":@"deleteFavourite"] parameters:parameters
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", [responseObject description]);
       
        
        

    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [Animations animateWithPopAndRotation:_favouriteButton fromSize:_favouriteButtonSize toSize:_venueLiked?40.0f:60.0f andNewImage:[UIImage imageNamed:_venueLiked?@"fav-btn.png":@"favourite-full.png"]];
        _venueLiked = !_venueLiked;
        
        
    }];
    
    
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    _venueLiked = NO;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *parameters = @{@"user_id": [self getUniqueDeviceIdentifierAsString],
                                 @"venue_id":_venue.venueId};
    
    [manager POST:[NSString stringWithFormat:@"%@/%@",REQUEST_URL, @"detectFavourite"] parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"JSON: %@", [responseObject description]);
              
              if([[responseObject objectForKey:@"isFavourite"] intValue]==1){

                  [Animations animateWithPopAndRotation:_favouriteButton fromSize:_favouriteButtonSize toSize:_venueLiked?40.0f:60.0f andNewImage:[UIImage imageNamed:_venueLiked?@"fav-btn.png":@"favourite-full.png"]];
                   _venueLiked = YES;
              }
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error %@", error);
          }];
    
    
    _favouriteButtonSize = _favouriteButton.frame;
    [self.scrollView setContentSize:CGSizeMake(320, 0)];
    
    NSLog(@"%@",self.venue.name);
    _descriptionTV.delegate = self;
    self.nameLabel.text = _venue.name;
    self.descriptionTV.text = _venue.descriptionEn;
    self.descriptionTV.font = [UIFont fontWithName:@"OpenSans" size:15.0f];
    self.descriptionTV.textColor = UIColorFromRGB(0x546470);
    
    _initialFrame = self.navigationController.navigationBar.frame;
    
    [self.view layoutIfNeeded];
    
    CGSize sizeThatShouldFitTheContent = [_descriptionTV sizeThatFits:_descriptionTV.frame.size];
    _tvHeightConstraing.constant = sizeThatShouldFitTheContent.height+100;
    [self.scrollView setContentSize:CGSizeMake(320, sizeThatShouldFitTheContent.height+100+100)];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.screenName = @"Venue Screen";
}

-(IBAction)detailsClick:(id)sender{
    /*self.navigationController.navigationItem.hidesBackButton = YES;
    self.navigationItem.hidesBackButton = YES;
    [UIView animateWithDuration:0.7
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, yScreenWidth, yScreenHeight)];
                         

                     }
                     completion:^(BOOL finished){*/
                         [self performSegueWithIdentifier:@"detailsView" sender:self];
    // }];*/
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue isKindOfClass:[BlurryModalSegue class]])
    {
        BlurryModalSegue* bms = (BlurryModalSegue*)segue;
        
        bms.backingImageBlurRadius = @(20);
        bms.backingImageSaturationDeltaFactor = @(.45);
        bms.backingImageTintColor = [UIColorFromRGB(UGOTURQUOISE) colorWithAlphaComponent:.6];
    }


    [segue.destinationViewController setVenue:_venue];
}

#pragma mark - QMBParallaxScrollViewHolder

- (UIScrollView *)scrollViewForParallexController{

    return self.scrollView;
}

- (IBAction)closeButtonTouchUpInside:(id)sender{
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
}



@end
