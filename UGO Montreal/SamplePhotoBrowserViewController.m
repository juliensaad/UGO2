//
//  SamplePhotoBrowserViewController.m
//  QMBParallaxScrollView-Sample
//
//  Created by Toni Möckel on 06.11.13.
//  Copyright (c) 2013 Toni Möckel. All rights reserved.
//

#import "SamplePhotoBrowserViewController.h"
#import "SDWebImageDownloader.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface SamplePhotoBrowserViewController ()

@property (nonatomic, strong) NSMutableArray *photos;

@property UIImageView* img;
@property UIImageView* icon;
@property UIView* iconbg;
@end

@implementation SamplePhotoBrowserViewController



- (void)viewDidLoad
{
 
    [super viewDidLoad];
    
    [self createIconography];
    [self createPersonaImage];


    [self loadVenueImages];
    [self createCustomPageControl];
}

-(void)createIconography{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    [manager downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%d.png",ICON_URL,_venue.icono]] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        _iconbg = [[UIView alloc] initWithFrame:CGRectMake(yScreenWidth-100, 20, 50, 50)];
        _iconbg.backgroundColor = _venue.color;
        _iconbg.layer.cornerRadius = 25;
        _iconbg.layer.borderWidth = 0;
        
        
        [self.view addSubview:_iconbg];
        
        _icon = [[UIImageView alloc] initWithImage:image];

        
        _icon.frame = CGRectMake(yScreenWidth-90, 30, 30, 30);
        _icon.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.view addSubview:_icon];
         [self performSelector:@selector(bringImgFront) withObject:self afterDelay:0.0];

    }];

}
-(void)createPersonaImage{
   
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    [manager downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/persona%@.jpg",PERSONA_URL,_venue.personaId]] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        _img = [[UIImageView alloc] initWithImage:image];
        [self.view addSubview:_img];
        
        _img.frame = CGRectMake(yScreenWidth-65, 20, 50, 50);
        _img.layer.cornerRadius = _img.frame.size.width/2;
        _img.layer.borderColor = [UIColor whiteColor].CGColor;
        _img.layer.borderWidth = 1.5;
        _img.contentMode = UIViewContentModeScaleAspectFill;
        _img.layer.masksToBounds = YES;
       
    }];

}

-(void)bringImgFront{
    [self.view bringSubviewToFront:_iconbg];
    [self.view bringSubviewToFront:_icon];
    [self.view bringSubviewToFront:_img];
}

-(void)createCustomPageControl{
    UINavigationController *navController = self.navigationController;
    navController.delegate = self;
    
    navController.navigationBar.barTintColor = UIColorFromRGB(UGOTURQUOISE);
    CGSize navBarSize = navController.navigationBar.bounds.size;
    CGPoint origin = CGPointMake( navBarSize.width/2, navBarSize.height/2 );
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(origin.x, origin.y,
                                                                       0, 0)];
    
    //Or whatever number of viewcontrollers you have
    [self.pageControl setNumberOfPages:self.photos.count];
    
    [navController.navigationBar addSubview:self.pageControl];
    
    navController.delegate = self;
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(currentPageChange:)
     name:@"currentPageChange"
     object:nil];
}

-(void)loadVenueImages{
    self.photos = [NSMutableArray array];
    
    for(int i = 0;i<_venue.imgUrls.count;i++){
        [self.photos addObject:[NSURL URLWithString:[_venue.imgUrls objectAtIndex:i]]];
    }

}
-(void)viewWillDisappear:(BOOL)animated{
    self.pageControl.hidden = YES;
}
-(void)viewWillAppear:(BOOL)animated{
    self.pageControl.hidden = NO;
}

-(void)currentPageChange:(NSNotification *)notification
{
    self.pageControl.currentPage = [[notification object] integerValue];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{

}

- (NSArray *) arrayWithImages
{
    return self.photos;
}

- (UIViewContentMode) contentModeForImage:(NSUInteger)image
{
    return UIViewContentModeScaleAspectFill;
}

@end
