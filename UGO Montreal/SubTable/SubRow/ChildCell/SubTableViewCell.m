//
//  SubTableViewCell.m
//  SubTableExample
//
//  Created by Alex Koshy on 7/16/14.
//  Copyright (c) 2014 ajkoshy7. All rights reserved.
//

#import "SubTableViewCell.h"

@implementation SubTableViewCell
@synthesize titleLabel;
@synthesize subtitleLabel;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [[self contentView] setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    if (!self)
        return self;
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.opaque = NO;
    titleLabel.textColor = UIColorFromRGB(0x546470);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLabel];
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupDisplay];
}

- (void)setupDisplay {
    
    [self.contentView setAutoresizesSubviews:YES];
    
    self.titleLabel.frame = CGRectMake(20, 17, 280, 20);
    //self.subtitleLabel.frame = CGRectMake(35, 30, 165, 16);
    
    //self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    //self.subtitleLabel.font = [UIFont systemFontOfSize:12];
}

- (void)setCellForegroundColor:(UIColor *)foregroundColor {
    titleLabel.textColor = UIColorFromRGB(0x546470);
    subtitleLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1.0];
}

- (void)setCellBackgroundColor:(UIColor *) backgroundColor {
    self.contentView.backgroundColor = backgroundColor;
}

@end
