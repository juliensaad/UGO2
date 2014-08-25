//
//  TypeCell.m
//  UGO Montreal
//
//  Created by Julien Saad on 2014-08-11.
//  Copyright (c) 2014 Développements Third Bridge Inc. All rights reserved.
//

#import "TypeCell.h"

@implementation TypeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    _typeLabel.font = [UIFont fontWithName:@"OpenSans-Bold" size:15.0f];
    _subLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
