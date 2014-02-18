//
//  PhotoNewsShowViewController.m
//  PhotoNewsClient
//
//  Created by xyooyy on 14-2-11.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import "PhotoNewsShowViewController.h"
#import "LibraryAPI.h"
#import "HorizontalScrollView.h"
#import "ImageNews.h"
#import "PhotoNewsShowView.h"
#import "UIViewController+MMDrawerController.h"

@interface PhotoNewsShowViewController ()<HorizontalScrollViewDelegate>
{
    HorizontalScrollView *horizontalScrollView;
    NSArray *allImageNews;
}

@end

@implementation PhotoNewsShowViewController

- (id)init
{
    self = [super init];
    if (self) {
        [[LibraryAPI sharedInstance] requestServer];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupScrollView)
                                              name:@"parseComplete" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - Private Methods
#pragma mark -setupScrollView
- (void)setupScrollView
{
    allImageNews = [[LibraryAPI sharedInstance] getImageNewsData];
    horizontalScrollView = [[HorizontalScrollView alloc] initWithFrame:self.view.bounds barButtonTarget:self];
    horizontalScrollView.delegate = self;
    [self.view addSubview: horizontalScrollView];
}

#pragma mark -rightMenuButtonAction
- (void)rightDrawerButtonPress
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - HorizontalScrollViewDelegate
- (NSInteger)numberOfViewsForHorizontalScrollView:(HorizontalScrollView *)scrollView
{
//    NSLog(@"%i", [allImageNews count]);
    return [allImageNews count];
}

- (UIView *)horziontalScrollView:(HorizontalScrollView *)scrollView viewAtIndex:(int)index
{
    ImageNews *indexImageNews = [allImageNews objectAtIndex:index];
    return [[PhotoNewsShowView alloc] initWithFrame:CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height) newsImageUrl:indexImageNews.image_url newsContent:indexImageNews.content];
}

#pragma mark - Dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"parseComplete" object:nil];
}

@end
