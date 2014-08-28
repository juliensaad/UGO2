//
//  TagsViewController.m
//  UGO Montreal
//
//  Created by Julien Saad on 2014-08-07.
//  Copyright (c) 2014 Développements Third Bridge Inc. All rights reserved.
//

#import "TagsViewController.h"
#import "AFNetworking.h"
#import "SubCategoriesViewController.h"
#import "TypeCell.h"
#import "SDWebImageManager.h"

@interface TagsViewController ()

@property NSMutableArray* tagTypes;

@property NSArray* tags;
@end

@implementation TagsViewController

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
    NSLog(@"%@",_category);
    
    self.titleItem.title = _categoryName;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    _tags = [NSArray array];
    NSDictionary *parameters = @{@"type": [NSNumber numberWithInteger:[_category integerValue]]};
    
    [manager POST:[NSString stringWithFormat:@"%@/getTagsFromType",REQUEST_URL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        _tags = responseObject;
        //[self fillTags:responseObject];
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];


}

-(void)fillTags:(NSArray*)tags{
    int i = 0;
    int btnHeight = 50;
    for(NSDictionary* d in tags){
        i++;
        UIButton*l = [[UIButton alloc] initWithFrame:CGRectMake(0, i*(btnHeight+5)+60, yScreenWidth, btnHeight)];
        
        [l setTitle:[d objectForKey:ISFRENCH?@"name_fr":@"name_en"] forState:UIControlStateNormal];
        
        [l addTarget:self action:@selector(goNext:) forControlEvents:UIControlEventTouchUpInside];
        
        l.tag = [[d objectForKey:@"id"] integerValue];
        l.backgroundColor = UIColorFromRGB(UGO_LIGHTGRAY);
        
        [l setTitleColor:UIColorFromRGB(TITLE_COLOR_DARK) forState:UIControlStateNormal];
        [l setTitleColor:UIColorFromRGB(UGOTURQUOISE) forState:UIControlStateHighlighted];
        [self.view addSubview:l];
        //NSLog(@"%@", l.titleLabel.text);
        
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        
        [manager downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/tag%ld.png",TAGS_URL,(long)l.tag]] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            [l setImage:image forState:UIControlStateNormal];
            [[l imageView] setContentMode:UIViewContentModeScaleAspectFit];
            //  NSLog(@"%@",[NSString stringWithFormat:@"%@/tag%ld.png",TAGS_URL,(long)l.tag]);
            
        }];

        
    }
}

-(void)goNext:(id)sender{
    [self performSegueWithIdentifier:@"goNext" sender:sender];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [[segue destinationViewController] setTagId:[NSString stringWithFormat:@"%d",[sender tag]]];
    
    [[segue destinationViewController] setTagName:[[sender typeLabel] text]];
    [[segue destinationViewController] setTagType:_category];
}



#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self goNext:[tableView cellForRowAtIndexPath:indexPath]];
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
    return _tags.count;
}

#define TYPE0 ISFRENCH?@"MANGER":@"EAT"
#define TYPE1 ISFRENCH?@"BOIRE":@"DRINK"
#define TYPE2 ISFRENCH?@"MAGASINER":@"SHOP"
#define TYPE3 ISFRENCH?@"BOUGER":@"MOVE"
#define TYPE4 ISFRENCH?@"APPRENDRE":@"LEARN"
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TypeCell" forIndexPath:indexPath];
    
    //cell.catIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%dcatIcon",indexPath.row]];

    
    //[l setTitle:[d objectForKey:ISFRENCH?@"name_fr":@"name_en"] forState:UIControlStateNormal];
    
    //[l addTarget:self action:@selector(goNext:) forControlEvents:UIControlEventTouchUpInside];
      
    NSDictionary *d = _tags[indexPath.row];
    cell.tag = [[d objectForKey:@"id"] integerValue];
    cell.typeLabel.text = [d objectForKey:ISFRENCH?@"name_fr":@"name_en"];
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    [manager downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/tag%ld.png",TAGS_URL,(long)cell.tag]] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        cell.catIcon.image = image;
        [[cell catIcon] setContentMode:UIViewContentModeScaleAspectFit];
        //  NSLog(@"%@",[NSString stringWithFormat:@"%@/tag%ld.png",TAGS_URL,(long)l.tag]);
        
    }];

    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.alpha = 0.0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:indexPath.row*0.1];
    cell.layer.transform = CATransform3DIdentity;
    cell.layer.opacity = 1;
    [UIView commitAnimations];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.screenName = @"Tag Screen";
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
