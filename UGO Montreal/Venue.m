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

-(void)setPriceText:(NSString *)priceText{
    int price = [priceText intValue];
    
    NSString* dollars = @"$";
    for(int i = 0;i<price;i++){
        dollars = [dollars stringByAppendingString:@"$"];
    }

    _priceText = [NSString stringWithFormat:@"%@ %@", lPRICING, dollars];
}

-(void)setBestTime:(NSString *)bestTime{
    _bestTime = [NSString stringWithFormat:@"%@ %@", lBEST_TIME,bestTime];
}
@end
