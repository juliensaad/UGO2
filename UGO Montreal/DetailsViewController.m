//
//  DetailsViewController.m
//  UGO Montreal
//
//  Created by Julien Saad on 2014-08-06.
//  Copyright (c) 2014 Développements Third Bridge Inc. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation DetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
       [UIView animateWithDuration:0.1
                          delay:0.7
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.navigationController.navigationBar setAlpha:0.0];
                         
                        
                     }
                     completion:^(BOOL finished){
                        
                         
                     }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationItem.hidesBackButton = NO;
    self.navigationItem.hidesBackButton = NO;
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, yScreenWidth, 66)];
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelay:0.4];
    
    [self.navigationController.navigationBar setAlpha:1.0];
        [UIView commitAnimations];
}
-(void)viewDidLayoutSubviews{

    CGRect frame = _contentView.frame;
    frame.origin.x = 600;
    _contentView.frame = frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationDelay:0.0];
    frame = _contentView.frame;
    frame.origin.x = 0;
    _contentView.frame = frame;
    
    [UIView commitAnimations];
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

- (IBAction)closeButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
