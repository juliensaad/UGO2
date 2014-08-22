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
#import "Venue.h"
#import "TNResizableTextView.h"

@interface VenueViewController : KingViewController<QMBParallaxScrollViewHolder, UIScrollViewDelegate, UIWebViewDelegate, UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tvHeightConstraing;
@property (weak, nonatomic) IBOutlet UIButton *favouriteButton;

@property Venue* venue;
@end
