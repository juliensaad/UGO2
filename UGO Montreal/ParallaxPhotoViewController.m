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
    
    _sampleTopViewController.venue = _venue;
    
    VenueViewController *v = [self.storyboard instantiateViewControllerWithIdentifier:@"VenueViewController"];
    v.venue = _venue;
    [self setupWithTopViewController:self.sampleTopViewController andTopHeight:250 andBottomViewController:v];
    
    self.delegate = self;
}

- (IBAction) dismiss:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
