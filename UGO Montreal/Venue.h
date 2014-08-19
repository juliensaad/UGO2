//
//  Venue.h
//  U:GO
//
//  Created by Julien Saad on 1/21/2014.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Venue : NSObject

@property NSString* name;
@property NSString* descriptionFr;
@property NSString* descriptionEn;

@property NSString* shortDesc;

@property NSString* fbUrl;
@property (nonatomic, setter = setLocation:) NSString* location;
@property NSString* venueId;

@property NSString* phoneNumber;
@property (nonatomic, setter = setBestTime:) NSString* bestTime;
@property (nonatomic, setter = setPriceText:) NSString* priceText;
@property int icono;
@property int price;

@property NSString* personaId;

@property UIColor* color;

@property int type;

@property NSMutableArray* imgUrls;
@property NSMutableArray* images;

@property NSString* dBID;



@end
