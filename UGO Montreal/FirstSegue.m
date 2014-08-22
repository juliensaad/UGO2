//
//  FirstSegue.m
//  UGO MTL
//
//  Created by Julien Saad on 2014-08-22.
//  Copyright (c) 2014 Développements Third Bridge Inc. All rights reserved.
//

#import "FirstSegue.h"

#import <pop/POP.h>
@implementation FirstSegue

-(void)perform{
    UIViewController *sourceViewController = (UIViewController*)[self sourceViewController];
    UIViewController *destinationController = (UIViewController*)[self destinationViewController];
    
    CALayer *layer = sourceViewController.view.layer;
    [layer pop_removeAllAnimations];
    
    // Scaling animation
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    anim.springBounciness = 16;
    anim.springSpeed = 8;
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(0,0, yScreenWidth+100,yScreenHeight+100)];
    
    
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        [sourceViewController.navigationController pushViewController:destinationController animated:NO];
    };
    
    [layer pop_addAnimation:anim forKey:@"size"];

}
@end
