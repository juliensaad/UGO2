//
//  DemoMenuController.m
//  Demo
//
//  Created by honcheng on 26/10/12.
//  Copyright (c) 2012 Hon Cheng Muh. All rights reserved.
//
//
#import "DemoMenuController.h"

@interface DemoMenuController ()

@end

@implementation DemoMenuController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setOnlyAllowEdgeDrag:NO];
       
    UIView *tableBgView = [[UIView alloc] initWithFrame:self.view.bounds];
    [tableBgView setBackgroundColor:UIColorFromRGB(0x2f383f)];
    
    UIView* smallerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 95, yScreenHeight)];
    [smallerView setBackgroundColor:UIColorFromRGB(0x3f4b54)];
    
    [tableBgView addSubview:smallerView];
    // [tableBgView setBackgroundColor:BLUECOLOR];
    [self.menuTableView setBackgroundView:tableBgView];
    [self.menuTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.menuTableView setContentInset:UIEdgeInsetsMake(20,0,0,0)];
    [self.menuTableView scrollRectToVisible:CGRectMake(0, 0, 320, 20) animated:NO];
    
    [self reloadMenu];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        
    }else{
        exit(0);
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 4){
        [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:ISFRENCH?@"en":@"fr", nil] forKey:@"AppleLanguages"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:ISFRENCH?@"en":@"fr", nil] forKey:@"PrefferedLanguages"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[[UIAlertView alloc] initWithTitle:ISFRENCH?@"":@""
                                   message:ISFRENCH?@"UGO doit redémarrer pour changer la langue.":@"UGO will restart to change the app language."
                                  delegate:self
                         cancelButtonTitle:ISFRENCH?@"Annuler":@"Cancel"
                         otherButtonTitles:ISFRENCH?@"Redémarrer":@"Restart", nil] show];
    }else if(indexPath.row==0){
        // launch about us
    }else{
        // launch favourites
    }
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel* textLabel;
    UIImageView* btn;
    if (tableView == self.menuTableView)
    {
        static NSString *identifier = @"identifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
           
            [cell setBackgroundColor:[UIColor clearColor]];
            
            
            btn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sidebar-lang"]];
            CGRect fr = btn.frame;
            fr.origin.x +=16;
            fr.origin.y +=15;
            btn.frame = fr;
            btn.tag = 13;
            
            textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, btn.frame.size.height+15, 95, 20)];
            textLabel.text = lOTHERLANG;
            textLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:12.0f];
            textLabel.textColor = [UIColor whiteColor];
            textLabel.textAlignment = NSTextAlignmentCenter;
            textLabel.tag = 12;
            
            [cell addSubview:textLabel];
            [cell addSubview:btn];

        
        }else{
            btn = (UIImageView*)[cell viewWithTag:13];
            textLabel = (UILabel*)[cell viewWithTag:12];
        }
        
        //UIViewController *viewController = self.viewControllers[indexPath.row];
        
        switch (indexPath.row) {
            case 0:
                [textLabel setText:lABOUT];
                btn.image = [UIImage imageNamed:@"sidebar-about"];
                break;
            case 1:
                [textLabel setText:lFAV];
                btn.image = [UIImage imageNamed:@"sidebar-fav"];
                
                break;
            case 2:
            case 3:
                btn.hidden = YES;
                textLabel.hidden = YES;
                cell.userInteractionEnabled = NO;               break;
                
            case 4:
                [textLabel setText:lOTHERLANG];
                btn.image = [UIImage imageNamed:@"sidebar-lang"];
                break;
            case 5:
                btn.hidden = YES;
                textLabel.hidden = YES;
                cell.userInteractionEnabled = NO;
                break;
            default:
                break;
        }
        
        if (indexPath.row == self.selectedIndex)
        {
            //[tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    
        
        return cell;
    }
    else
    {
        return nil;
    }
}


@end
