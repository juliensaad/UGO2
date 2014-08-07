//
//  SamplePhotoBrowserViewController.h
//  QMBParallaxScrollView-Sample
//
//  Created by Toni Möckel on 06.11.13.
//  Copyright (c) 2013 Toni Möckel. All rights reserved.
//

#import "Venue.h"

@interface SamplePhotoBrowserViewController : UIViewController<UINavigationControllerDelegate>
@property (nonatomic, strong) UIPageControl *pageControl;

@property Venue* venue;

@end
