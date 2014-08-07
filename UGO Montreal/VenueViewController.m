//
//  SampleScrollViewController.m
//  QMBParallaxScrollView-Sample
//
//  Created by Toni Möckel on 02.11.13.
//  Copyright (c) 2013 Toni Möckel. All rights reserved.
//

#import "VenueViewController.h"
#import "AFNetworking.h"


@interface VenueViewController ()

@property CGRect initialFrame;
@end

@implementation VenueViewController

- (void)awakeFromNib{
    
    
}

-(NSString *)getUniqueDeviceIdentifierAsString
{
    
    NSString *appName=[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    
    NSString *strApplicationUUID = [SSKeychain passwordForService:appName account:@"incoding"];
    if (strApplicationUUID == nil)
    {
        strApplicationUUID  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [SSKeychain setPassword:strApplicationUUID forService:appName account:@"incoding"];
    }
    NSLog(@"%@", strApplicationUUID);
    return strApplicationUUID;
}

- (IBAction)favouriteClick:(id)sender {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *parameters = @{@"user_id": [self getUniqueDeviceIdentifierAsString],
                                 @"venue_id":_venue.venueId};
    
    [manager POST:[NSString stringWithFormat:@"%@/addFavourite",REQUEST_URL] parameters:parameters
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    _tvHeightConstraing.constant = sizeThatShouldFitTheContent.height+50;
    [self.scrollView setContentSize:CGSizeMake(320, sizeThatShouldFitTheContent.height+50+100)];
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

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationItem.hidesBackButton = NO;
    self.navigationItem.hidesBackButton = NO;
    self.navigationController.navigationBar.alpha = 1.0;
    [self.navigationController.navigationBar setFrame:_initialFrame];
    NSLog(@"InitialFrame");
}

-(IBAction)detailsClick:(id)sender{
    self.navigationController.navigationItem.hidesBackButton = YES;
    self.navigationItem.hidesBackButton = YES;
    [UIView animateWithDuration:0.7
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, yScreenWidth, yScreenHeight)];
                         

                     }
                     completion:^(BOOL finished){
                         [self performSegueWithIdentifier:@"detailsView" sender:self];
                     }];
}

#pragma mark - QMBParallaxScrollViewHolder

- (UIScrollView *)scrollViewForParallexController{

    return self.scrollView;
}

- (IBAction)closeButtonTouchUpInside:(id)sender{
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
}



@end
