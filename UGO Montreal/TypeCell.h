//
//  TypeCell.h
//  UGO Montreal
//
//  Created by Julien Saad on 2014-08-11.
//  Copyright (c) 2014 Développements Third Bridge Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *catIcon;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *subLabel;

@end
