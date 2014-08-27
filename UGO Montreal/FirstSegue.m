//
//  FirstSegue.m
//  UGO MTL
//
//  Created by Julien Saad on 2014-08-22.
//  Copyright (c) 2014 Développements Third Bridge Inc. All rights reserved.
//

#import "FirstSegue.h"
#import "HomePageViewController.h"
#import <pop/POP.h>
@implementation FirstSegue

-(void)perform{
    HomePageViewController *sourceViewController = (HomePageViewController*)[self sourceViewController];
    UIViewController *destinationController = (UIViewController*)[self destinationViewController];
    /*
    CGRect emptyFrame = CGRectMake(yScreenWidth/2, yScreenHeight/2, 0, 0);
    [UIView animateWithDuration:0.5 animations:^{
        for(UIView * v in sourceViewController.view.subviews){
            //if([v isKindOfClass:[UILabel class]])
                v.frame = emptyFrame;
        }
        // sourceViewController.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [sourceViewController.navigationController pushViewController:destinationController animated:NO];
    }];
    */
    /*CALayer *layer = [[sourceViewController subContainer] cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].layer;
    [layer pop_removeAllAnimations];
    
    // Scaling animation
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    anim.springBounciness = 3;
    anim.springSpeed = 8;
    anim.toValue = [NSValue valueWithCGSize:CGSizeMake(0.1, 0.1)];//[NSValue valueWithCGRect:CGRectMake(yScreenWidth/2,yScreenHeight/2, 0,0)];
    
    
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        [sourceViewController.navigationController pushViewController:destinationController animated:NO];
    };
    
    [layer pop_addAnimation:anim forKey:@"size"];
     */
}
@end
