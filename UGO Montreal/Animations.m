//
//  Animations.m
//  UGO MTL
//
//  Created by Julien Saad on 2014-08-22.
//  Copyright (c) 2014 Développements Third Bridge Inc. All rights reserved.
//

#import "Animations.h"
#import <QuartzCore/QuartzCore.h>

@implementation Animations

+(void)animateWithPopAndRotation:(UIView*)v fromSize:(CGRect)originalFrame toSize:(CGFloat)size andNewImage:(UIImage*)img{
    CALayer *layer = v.layer;
    [layer pop_removeAllAnimations];
    
    // Scaling animation
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    anim.springBounciness = 16;
    anim.springSpeed = 8;
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, size, size)];
    
    // Rotation animation
    POPSpringAnimation *rotation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    rotation.toValue = @(2*M_PI);
    rotation.springBounciness = 14;
    rotation.springSpeed = 5;
    
    [((UIButton*)v) setBackgroundImage:img forState:UIControlStateNormal];
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        POPBasicAnimation *anim2 = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerBounds];
        
        anim2.toValue = [NSValue valueWithCGRect:originalFrame];
        
        [layer pop_addAnimation:anim2 forKey:@"decay"];
    };
    
    [layer pop_addAnimation:anim forKey:@"size"];
    [layer pop_addAnimation:rotation forKey:@"rotation"];
    
}


@end
