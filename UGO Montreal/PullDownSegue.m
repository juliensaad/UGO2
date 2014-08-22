//
//  PullDownSegue.m
//  UGO MTL
//
//  Created by Julien Saad on 2014-08-21.
//  Copyright (c) 2014 Développements Third Bridge Inc. All rights reserved.
//

#import "PullDownSegue.h"
#import <pop/POP.h>
#import "VenueViewController.h"
@implementation PullDownSegue


-(void)perform {
    
    VenueViewController *sourceViewController = (VenueViewController*)[self sourceViewController];
    UIViewController *destinationController = (UIViewController*)[self destinationViewController];
    
    NSLog(@"Current class: %@", [sourceViewController class]);
    CALayer *layer = sourceViewController.favouriteButton.layer;
    [layer pop_removeAllAnimations];
    
    POPSpringAnimation *xAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    POPSpringAnimation *sizeAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
    
    xAnim.fromValue = @(yScreenWidth);
    xAnim.springBounciness = 16;
    xAnim.springSpeed = 8;
    
    sizeAnim.fromValue = [NSValue valueWithCGSize:CGSizeMake(64, 114)];
    
    xAnim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        [sourceViewController.navigationController pushViewController:destinationController animated:NO];
    };
    
    [layer pop_addAnimation:xAnim forKey:@"position"];
    [layer pop_addAnimation:sizeAnim forKey:@"size"];
    
    
}


@end
