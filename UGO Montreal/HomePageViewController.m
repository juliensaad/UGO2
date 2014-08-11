//
//  HomePageViewController.m
//  UGO Montreal
//
//  Created by Julien Saad on 2014-08-05.
//  Copyright (c) 2014 Développements Third Bridge Inc. All rights reserved.
//

#import "HomePageViewController.h"
#import "TagsViewController.h"
#import "HomeTableViewController.h"

@interface HomePageViewController ()
@property (weak, nonatomic) IBOutlet UILabel *topTitle;

@end

@implementation HomePageViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)hamburgerClick:(id)sender {

    [_sideMenu showMenu:[[_sideMenu paperFoldView] state]==PaperFoldStateLeftUnfolded?PaperFoldStateDefault:PaperFoldStateLeftUnfolded animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    [segue.destinationViewController setCategory:[NSString stringWithFormat:@"%d",_nextView]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navLogo"]];
    _topTitle.font = [UIFont fontWithName:@"OpenSans-Bold" size:17.0f];
    
 /*   UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hamburger"]]];
    
    item.target = self;
    item.action = @selector(hamburger);
    self.navigationItem.rightBarButtonItem = item;*/
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
