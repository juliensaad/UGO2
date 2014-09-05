//
//  DetailsViewController.m
//  UGO Montreal
//
//  Created by Julien Saad on 2014-08-06.
//  Copyright (c) 2014 Développements Third Bridge Inc. All rights reserved.
//

#import "DetailsViewController.h"
#import <MapKit/MapKit.h>
@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation DetailsViewController

CLLocationCoordinate2D center;

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
    
    [self fillVenueInfo];
   /* self.navigationItem.hidesBackButton = YES;
       [UIView animateWithDuration:0.1
                          delay:0.7
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.navigationController.navigationBar setAlpha:0.0];
                         

                     }
                     completion:^(BOOL finished){
                        
                         
                     }];*/
    
}

-(void)fillVenueInfo{
    _addressLabel.text = _venue.location;
    _bestTimeLabel.text = _venue.bestTime;
    _nameLabel.text = _venue.name;
    _priceLabel.text = _venue.priceText;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated{
   /* self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationItem.hidesBackButton = NO;
    self.navigationItem.hidesBackButton = NO;
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, yScreenWidth, 66)];
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelay:0.4];
    
    [self.navigationController.navigationBar setAlpha:1.0];
        [UIView commitAnimations];*/
}
-(void)viewDidLayoutSubviews{

    /*CGRect frame = _contentView.frame;
    frame.origin.x = 600;
    _contentView.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationDelay:0.0];
    frame = _contentView.frame;
    frame.origin.x = 0;
    _contentView.frame = frame;
    
    [UIView commitAnimations];*/
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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.screenName = @"Details Screen";
}

- (IBAction)closeButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)mapClick:(id)sender {
    [self openActionSheet:self];
}

- (CLLocationCoordinate2D) geoCodeUsingAddress:(NSString *)address
{
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    
    center.latitude = latitude;
    center.longitude = longitude;
    
    //give the user a choice of Apple or Google Maps
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Open in Maps" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Apple Maps",@"Google Maps", nil];
    [sheet showInView:self.view];

    return center;
}

-(void)openActionSheet:(id)sender {
    [self geoCodeUsingAddress:_venue.location];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    //coordinates for the place we want to display
    CLLocationCoordinate2D rdOfficeLocation = CLLocationCoordinate2DMake(center.latitude,center.longitude);
    if (buttonIndex==0) {
        //Apple Maps, using the MKMapItem class
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:rdOfficeLocation addressDictionary:nil];

        MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:placemark];
        item.name = [NSString stringWithFormat:@"%@\n%@",_venue.name, _venue.location];
        [item openInMapsWithLaunchOptions:nil];
    } else if (buttonIndex==1) {
        //Google Maps
        //construct a URL using the comgooglemaps schema
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps://?center=%f,%f",center.latitude,center.longitude]];
        if (![[UIApplication sharedApplication] canOpenURL:url]) {
            NSLog(@"Google Maps app is not installed");
            //left as an exercise for the reader: open the Google Maps mobile website instead!
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

- (IBAction)callClick:(id)sender {
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] ) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",_venue.phoneNumber]]];
    } else {
        UIAlertView *notPermitted=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [notPermitted show];
        
    }
}

- (IBAction)facebookClick:(id)sender {
        NSURL *url = [NSURL URLWithString:_venue.fbUrl];
        [[UIApplication sharedApplication] openURL:url];
        
}

- (IBAction)favClick:(id)sender {
}
@end
