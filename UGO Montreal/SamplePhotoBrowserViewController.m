//
//  SamplePhotoBrowserViewController.m
//  QMBParallaxScrollView-Sample
//
//  Created by Toni Möckel on 06.11.13.
//  Copyright (c) 2013 Toni Möckel. All rights reserved.
//

#import "SamplePhotoBrowserViewController.h"

@interface SamplePhotoBrowserViewController ()

@property (nonatomic, strong) NSMutableArray *photos;

@end

@implementation SamplePhotoBrowserViewController



- (void)viewDidLoad
{
    self.photos = [NSMutableArray array];
    [self.photos addObject:[UIImage imageNamed:@"background.png"]];
    [self.photos addObject:[UIImage imageNamed:@"background.png"]];
    [self.photos addObject:[UIImage imageNamed:@"background.png"]];
    [self.photos addObject:[UIImage imageNamed:@"background.png"]];

    [super viewDidLoad];
    UINavigationController *navController = self.navigationController;
    navController.delegate = self;
    
    navController.navigationBar.barTintColor = UIColorFromRGB(UGOTURQUOISE);
    CGSize navBarSize = navController.navigationBar.bounds.size;
    CGPoint origin = CGPointMake( navBarSize.width/2, navBarSize.height/2 );
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(origin.x, origin.y,
                                                                       0, 0)];
    
    //Or whatever number of viewcontrollers you have
    [self.pageControl setNumberOfPages:self.photos.count];
    
    [navController.navigationBar addSubview:self.pageControl];
    
    navController.delegate = self;
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(currentPageChange:)
     name:@"currentPageChange"
     object:nil];
    
    
}

-(void)currentPageChange:(NSNotification *)notification
{
    self.pageControl.currentPage = [[notification object] integerValue];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"ALERT!!!");
}

- (NSArray *) arrayWithImages
{
    return self.photos;
}

- (UIViewContentMode) contentModeForImage:(NSUInteger)image
{
    return UIViewContentModeScaleAspectFill;
}

@end
