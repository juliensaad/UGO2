//
//  SampleScrollViewController.m
//  QMBParallaxScrollView-Sample
//
//  Created by Toni Möckel on 02.11.13.
//  Copyright (c) 2013 Toni Möckel. All rights reserved.
//

#import "VenueViewController.h"


@interface VenueViewController ()

@end

@implementation VenueViewController

- (void)awakeFromNib{
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.scrollView setContentSize:CGSizeMake(320, 0)];
	
    
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


#pragma mark - QMBParallaxScrollViewHolder

- (UIScrollView *)scrollViewForParallexController{

    return self.scrollView;
}

- (IBAction)closeButtonTouchUpInside:(id)sender{
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
