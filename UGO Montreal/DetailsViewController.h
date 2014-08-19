//
//  DetailsViewController.h
//  UGO Montreal
//
//  Created by Julien Saad on 2014-08-06.
//  Copyright (c) 2014 Développements Third Bridge Inc. All rights reserved.
//

#import "KingViewController.h"
#import "Venue.h"

@interface DetailsViewController : KingViewController

- (IBAction)closeButtonClick:(id)sender;
@property Venue* venue;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bestTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *mapClick;
@property (weak, nonatomic) IBOutlet UIButton *callClick;
@property (weak, nonatomic) IBOutlet UIButton *fbClick;
@property (weak, nonatomic) IBOutlet UIButton *favClick;
- (IBAction)mapClick:(id)sender;
- (IBAction)callClick:(id)sender;
- (IBAction)facebookClick:(id)sender;
- (IBAction)favClick:(id)sender;

@end
