//
//  TagsViewController.h
//  UGO Montreal
//
//  Created by Julien Saad on 2014-08-07.
//  Copyright (c) 2014 Développements Third Bridge Inc. All rights reserved.
//

#import "KingViewController.h"

@interface TagsViewController : KingViewController<UITableViewDelegate, UITableViewDataSource>

@property NSString* category;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UINavigationItem *titleItem;
@property NSString* categoryName;
@end
