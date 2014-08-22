//
//  Animations.h
//  UGO MTL
//
//  Created by Julien Saad on 2014-08-22.
//  Copyright (c) 2014 Développements Third Bridge Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <pop/POP.h>

@interface Animations : NSObject

typedef void (^completionBlock)(POPAnimation *anim, BOOL finished);

+(void)animateWithPopAndRotation:(UIView*)v fromSize:(CGRect)originalFrame toSize:(CGFloat)size andNewImage:(UIImage*)img;
@end
