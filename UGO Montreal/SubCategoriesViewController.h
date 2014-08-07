//
//  SubCategoriesViewController.h
//  UGO Montreal
//
//  Created by Julien Saad on 2014-08-05.
//  Copyright (c) 2014 Développements Third Bridge Inc. All rights reserved.
//

#import "KingViewController.h"
#import "Persona.h"
#import "Venue.h"
#import "PersonaCard.h"

@interface SubCategoriesViewController : KingViewController
- (IBAction)backClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property NSString* tagType;
@property NSString* tagName;

@property NSMutableArray* venuesAndPersonas;
@end
