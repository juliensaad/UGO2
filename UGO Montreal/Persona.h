//
//  Persona.h
//  U:GO
//
//  Created by Julien Saad on 1/21/2014.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Venue.h"

@interface Persona : NSObject

@property NSString* name;

@property NSString* personaId;
@property NSString* personaDescription;
@property NSString* personaDescriptionFr;
@property NSString* personaNameFr;
@property NSString* imgUrl;

-(void)makePersonaName:(NSString*)name;

@property UIImage* img;
@property NSMutableArray* venues;

@end
