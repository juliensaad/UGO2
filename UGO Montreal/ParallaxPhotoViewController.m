//
//  ParallaxPhotoViewController.m
//  QMBParallaxScrollView-Sample
//
//  Created by Toni Möckel on 07.11.13.
//  Copyright (c) 2013 Toni Möckel. All rights reserved.
//

#import "ParallaxPhotoViewController.h"
#import "SamplePhotoBrowserViewController.h"
#import "VenueViewController.h"


@interface ParallaxPhotoViewController ()

@property (nonatomic, strong) SamplePhotoBrowserViewController *sampleTopViewController;

@end

@implementation ParallaxPhotoViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sampleTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SamplePhotoBrowserViewController"];
    
    VenueViewController *v = [self.storyboard instantiateViewControllerWithIdentifier:@"VenueViewController"];
    
    [self setupWithTopViewController:self.sampleTopViewController andTopHeight:320 andBottomViewController:v];
    
    self.delegate = self;
}

- (IBAction) dismiss:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
