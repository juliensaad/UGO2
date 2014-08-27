//
//  AboutViewController.h
//  UGO MTL
//
//  Created by Julien Saad on 2014-08-27.
//  Copyright (c) 2014 Développements Third Bridge Inc. All rights reserved.
//

#import "KingViewController.h"
#import "DemoMenuController.h"

@interface AboutViewController : KingViewController

@property DemoMenuController* sideMenu;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *hamburgerClick;
- (IBAction)hamburgerClick:(id)sender;

@end
