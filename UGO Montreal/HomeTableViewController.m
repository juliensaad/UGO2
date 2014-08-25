//
//  HomeTableViewController.m
//  UGO Montreal
//
//  Created by Julien Saad on 2014-08-11.
//  Copyright (c) 2014 Développements Third Bridge Inc. All rights reserved.
//

#import "HomeTableViewController.h"
#import "TypeCell.h"
#import "TagsViewController.h"
#import "HomePageViewController.h"

@interface HomeTableViewController ()

@end


@implementation HomeTableViewController



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(!ISIPHONE5){
        self.tableView.bounces = YES;
    }
    
    // [self.tableView registerClass:[TypeCell class] forCellReuseIdentifier:@"TypeCell"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        _nextView = indexPath.row;
    
    ((HomePageViewController*)self.parentViewController).catName = [[(TypeCell*)[tableView cellForRowAtIndexPath:indexPath] typeLabel] text];
    
    if(_nextView==3)
        _nextView = 2;
    else if(_nextView == 2)
        _nextView = 3;
    ((HomePageViewController*)self.parentViewController).nextView = _nextView;
    
 
    
    [self.parentViewController performSegueWithIdentifier:@"tagSegue" sender:self];

}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 5;
}

#define TYPE0 ISFRENCH?@"MANGER":@"EAT"
#define TYPE1 ISFRENCH?@"BOIRE":@"DRINK"
#define TYPE2 ISFRENCH?@"MAGASINER":@"SHOP"
#define TYPE3 ISFRENCH?@"BOUGER":@"MOVE"
#define TYPE4 ISFRENCH?@"APPRENDRE":@"LEARN"
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TypeCell" forIndexPath:indexPath];
    
    cell.catIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%dcatIcon",indexPath.row]];
    
    switch (indexPath.row) {
        case 0:
            cell.typeLabel.text = TYPE0;
            cell.subLabel.text = lcat1;
            break;
        case 1:
            cell.typeLabel.text = TYPE1;
            cell.subLabel.text = lcat2;
            break;
        case 2:
            cell.typeLabel.text = TYPE3;
            cell.subLabel.text = lcat4;
            break;
        case 3:
            cell.typeLabel.text = TYPE2;
            cell.subLabel.text = lcat3;
            break;
        case 4:
            cell.typeLabel.text = TYPE4;
            cell.subLabel.text = lcat5;
            break;
            
        default:
            break;
    }
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
