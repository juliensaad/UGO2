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

#import "SDWebImageManager.h"

@interface TagsViewController ()

@property NSMutableArray* tagTypes;
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
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    NSDictionary *parameters = @{@"type": [NSNumber numberWithInteger:[_category integerValue]]};
    
    [manager POST:[NSString stringWithFormat:@"%@/getTagsFromType",REQUEST_URL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        [self fillTags:responseObject];
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
    
    [[segue destinationViewController] setTagName:[[sender titleLabel] text]];
    [[segue destinationViewController] setTagType:_category];
}


@end
