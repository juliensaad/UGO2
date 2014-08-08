//
//  Venue.m
//  U:GO
//
//  Created by Julien Saad on 1/21/2014.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import "Venue.h"

@implementation Venue

-(void)setLocation:(NSString *)location{
    location = [location stringByReplacingOccurrencesOfString:@"Montreal" withString:@"\nMontreal"];
    location = [location stringByReplacingOccurrencesOfString:@"Montréal" withString:@"\nMontréal"];
    
    location = [location stringByReplacingOccurrencesOfString:@"Canada" withString:@"\nCanada"];
    
    _location = location;
}
@end
