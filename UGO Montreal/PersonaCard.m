//
//  PersonaCard.m
//  UGO Montreal
//
//  Created by Julien Saad on 2014-08-05.
//  Copyright (c) 2014 Développements Third Bridge Inc. All rights reserved.
//

#import "PersonaCard.h"
#import "SDWebImage/UIImageView+WebCache.h"

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
#define LABEL_HEIGHT 20
-(void)setPersona:(Persona*)p{
    
    // Create the top view
    UIView* personaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, PersonaHeight)];
    
    UIView* bottomLine = [[UIView alloc] initWithFrame:CGRectMake(XPADDING, PersonaHeight-0.5, self.frame.size.width-XPADDING, 0.5)];
    bottomLine.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [personaView addSubview:bottomLine];
    
    UIImageView* face = [[UIImageView alloc] init];
   
    [face setFrame:CGRectMake(XPADDING, PersonaHeight/2-FACEFRAME/2, FACEFRAME, FACEFRAME)];
    face.layer.masksToBounds = YES;
    face.layer.cornerRadius = FACEFRAME/2;
    [personaView addSubview:face];
    face.contentMode = UIViewContentModeScaleAspectFill;
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    [manager downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/persona%@.jpg",IMG_URL,p.personaId]] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        face.image = image;
        NSLog(@"%@", [NSString stringWithFormat:@"%@/persona%@.jpg",IMG_URL,p.personaId]);
    }];
    
    [self addSubview:personaView];
    
    // Iterate to create all the other views
    int i = 0;
    int currentY = 0;
    for(Venue* v in p.venues){
        currentY = PersonaHeight + RowHeight*i;
        UIButton* venueView = [[UIButton alloc] initWithFrame:CGRectMake(0, currentY, self.frame.size.width, RowHeight)];
        
        UIView* bottomLineVenue = [[UIView alloc] initWithFrame:CGRectMake(XPADDING, RowHeight-0.5, self.frame.size.width-XPADDING, 0.5)];
        bottomLineVenue.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];

        UILabel* l = [[UILabel alloc] initWithFrame:CGRectMake(XPADDING, 18, self.frame.size.width-XPADDING, LABEL_HEIGHT)];
        l.text = v.name;
        l.textColor = UIColorFromRGB(TITLE_COLOR_DARK);
        l.font = [UIFont fontWithName:@"OpenSans-Semibold" size:14.0f];
        
        UILabel* subtitle = [[UILabel alloc] initWithFrame:CGRectMake(XPADDING, 14+LABEL_HEIGHT, self.frame.size.width-XPADDING*4, LABEL_HEIGHT)];
        subtitle.text = v.descriptionEn;
        subtitle.textColor = UIColorFromRGB(SUBTITLE_COLOR_DARK);
        subtitle.font = [UIFont fontWithName:@"OpenSans" size:12.0f];
        
        UIImageView* arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forward-arrow"]];
        arrow.frame = CGRectMake(self.frame.size.width-XPADDING-arrow.frame.size.width, RowHeight/2-arrow.frame.size.height/2, arrow.frame.size.width, arrow.frame.size.height);
        arrow.alpha = 0.75;
        
        [venueView addSubview:arrow];
        [venueView addSubview:bottomLineVenue];
        [venueView addSubview:l];
        [venueView addSubview:subtitle];
        
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
