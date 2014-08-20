//
//  HomePageViewController.h
//  UGO Montreal
//
//  Created by Julien Saad on 2014-08-05.
//  Copyright (c) 2014 Développements Third Bridge Inc. All rights reserved.
//

#import "KingViewController.h"

#import "DemoMenuController.h"
@interface HomePageViewController : KingViewController
@property DemoMenuController* sideMenu;

@property int nextView;
@property NSString* catName;
@end
