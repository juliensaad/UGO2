//
//  TNResizableTextView.m
//
//  Created by Nikita Took on 25.07.14.
//

#import "TNResizableTextView.h"

@implementation TNResizableTextView
- (void) updateConstraints {
    // calculate contentSize manually (ios7 doesn't calculate it before viewDidAppear, and we'll get here before)
    CGSize contentSize = [self sizeThatFits:CGSizeMake(self.frame.size.width, FLT_MAX)];
    
    // set the height constraint to change textView height
    [self.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            constraint.constant = contentSize.height;
            *stop = YES;
        }
    }];
    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = [self sizeThatFits:CGSizeMake(self.bounds.size.width, FLT_MAX)];
    
    if (!self.heightConstraint) {
        self.heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1.0f constant:size.height];
        [self addConstraint:self.heightConstraint];
    }
    
    self.heightConstraint.constant = size.height;
    
    [super layoutSubviews];
}

@end
