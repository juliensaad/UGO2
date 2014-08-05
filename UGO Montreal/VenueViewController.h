//
//  SampleScrollViewController.h
//  QMBParallaxScrollView-Sample
//
//  Created by Toni Möckel on 02.11.13.
//  Copyright (c) 2013 Toni Möckel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QMBParallaxScrollViewController.h"
#import "KingViewController.h"
@interface VenueViewController : KingViewController<QMBParallaxScrollViewHolder, UIScrollViewDelegate, UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
