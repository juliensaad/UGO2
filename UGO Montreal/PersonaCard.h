//
//  PersonaCard.h
//  UGO Montreal
//
//  Created by Julien Saad on 2014-08-05.
//  Copyright (c) 2014 Développements Third Bridge Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Persona.h"
#import "Venue.h"
#import <QuartzCore/QuartzCore.h>

@interface PersonaCard : UIView

-(id)initWithNumberOfVenues:(int)num andY:(CGFloat)y;

-(void)setPersona:(Persona*)p
      andSelector:(SEL)selector andSender:(id)sender;
@end
