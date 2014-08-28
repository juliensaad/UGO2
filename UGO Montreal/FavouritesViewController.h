//
//  FavouritesViewController.h
//  UGO MTL
//
//  Created by Julien Saad on 2014-08-27.
//  Copyright (c) 2014 Développements Third Bridge Inc. All rights reserved.
//

#import "KingViewController.h"
#import "ParentTableView.h"
#import "ParentTableViewCell.h"
#import "SubTableView.h"
#import "SubTableViewCell.h"

@interface FavouritesViewController : KingViewController<SubTableViewDelegate, SubTableViewDataSource>
@property (weak, nonatomic) IBOutlet ParentTableView *tableView;

@end
