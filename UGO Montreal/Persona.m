//
//  Persona.m
//  U:GO
//
//  Created by Julien Saad on 1/21/2014.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import "Persona.h"

@implementation Persona

-(void)makePersonaName:(NSString*)name{
    self.personaNameFr = name;
}

-(id)init{
    self = [super init];
    if(self)
    {
        self.venues = [[NSMutableArray alloc] init];
    }
    return self;
}
@end
