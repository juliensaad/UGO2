//
//  ParentTableViewCell.m
//  SubTableExample
//
//  Created by Alex Koshy on 7/16/14.
//  Copyright (c) 2014 ajkoshy7. All rights reserved.
//

#import "ParentTableViewCell.h"

@implementation ParentTableViewCell
@synthesize parentIndex;
@synthesize titleLabel;
@synthesize subtitleLabel;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier; {
    
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [[self contentView] setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    if (!self) {
        return self;
    }
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 11, 200, 23)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.opaque = NO;
    titleLabel.textColor = UIColorFromRGB(UGOTURQUOISE);
    titleLabel.font = [UIFont fontWithName:@"OpenSans-Bold" size:12.0f];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLabel];
    
    self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(yScreenWidth-90, 11, 80, 23)];
    subtitleLabel.backgroundColor = [UIColor clearColor];
    subtitleLabel.opaque = NO;
    subtitleLabel.textColor = UIColorFromRGB(0x546470);
    subtitleLabel.font = [UIFont fontWithName:@"OpenSans" size:10.0f];
    subtitleLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:subtitleLabel];
    
    
    UIImageView* bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fav-bg-0"]];
    self.frame = bg.frame;
    [self.contentView addSubview:bg];
    [self.contentView sendSubviewToBack:bg];
    
    [self.contentView setAutoresizesSubviews:YES];
    
    return self;
}

- (void)setCellForegroundColor:(UIColor *)foregroundColor {
    self.titleLabel.textColor = foregroundColor;
    self.subtitleLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1.0];
}
- (void)setCellBackgroundColor:(UIColor *)backgroundColor {
    self.contentView.backgroundColor = backgroundColor;
}

@end
