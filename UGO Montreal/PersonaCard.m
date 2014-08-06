//
//  PersonaCard.m
//  UGO Montreal
//
//  Created by Julien Saad on 2014-08-05.
//  Copyright (c) 2014 Développements Third Bridge Inc. All rights reserved.
//

#import "PersonaCard.h"

@implementation PersonaCard

#define XPADDING 20
#define PersonaHeight 90
#define RowHeight 70

#define BottomPadding 0

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8; // if you like rounded corners
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowRadius = 1;
        self.layer.shadowOpacity = 0.2;
    }
    return self;
}

-(id)initWithNumberOfVenues:(int)num andY:(CGFloat)y{
    
    self = [super initWithFrame:CGRectMake(XPADDING/2, y, yScreenWidth-XPADDING, PersonaHeight+RowHeight*num+BottomPadding)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 2; // if you like rounded corners
        self.layer.shadowOffset = CGSizeMake(0, 2);
        self.layer.shadowRadius = 2;
        self.layer.shadowOpacity = 0.2;

    }
    return self;
}

#define FACEFRAME 50
#define LABEL_HEIGHT 40
-(void)setPersona:(Persona*)p{
    
    // Create the top view
    UIView* personaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, PersonaHeight)];
    
    UIView* bottomLine = [[UIView alloc] initWithFrame:CGRectMake(XPADDING, PersonaHeight-0.5, self.frame.size.width-XPADDING, 0.5)];
    bottomLine.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [personaView addSubview:bottomLine];
    
    UIImageView* face = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    
    [face setFrame:CGRectMake(XPADDING, PersonaHeight/2-FACEFRAME/2, FACEFRAME, FACEFRAME)];
    face.layer.masksToBounds = YES;
    face.layer.cornerRadius = FACEFRAME/2;
    
    [personaView addSubview:face];
    
    [self addSubview:personaView];
    
    // Iterate to create all the other views
    
    int i = 0;
    int currentY = 0;
    for(Venue* v in p.venues){
        currentY = PersonaHeight + RowHeight*i;
        UIView* venueView = [[UIView alloc] initWithFrame:CGRectMake(0, currentY, self.frame.size.width, RowHeight)];
        
        UIView* bottomLineVenue = [[UIView alloc] initWithFrame:CGRectMake(XPADDING, RowHeight-0.5, self.frame.size.width-XPADDING, 0.5)];
        bottomLineVenue.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        [venueView addSubview:bottomLineVenue];
        
        UILabel* l = [[UILabel alloc] initWithFrame:CGRectMake(XPADDING, 10, self.frame.size.width-XPADDING, LABEL_HEIGHT)];
        l.text = v.name;
        l.textColor = [UIColor blackColor];
        
        [venueView addSubview:l];
        
        [self addSubview:venueView];
        i++;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
