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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadScrollView:)
                                                     name:@"requestComplete" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSelectView:) name:@"showSelectView" object:nil];
        [[LibraryAPI sharedInstance] requestServer];
        horizontalScrollView = [[HorizontalScrollView alloc] initWithFrame:self.view.bounds barButtonTarget:self];
        horizontalScrollView.delegate = self;
        [self.view addSubview: horizontalScrollView];
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Private Methods
#pragma mark -reloadScrollView
- (void)reloadScrollView:(NSNotification *)notification
{
    allImageNews = [[LibraryAPI sharedInstance] getImageNewsData];
    [horizontalScrollView reload];
    [notification.userInfo[@"alertView"] show];
}

- (void)showSelectView:(NSNotification *)notification
{
    [horizontalScrollView showIndexView: [notification.userInfo[@"index"] integerValue]];
}


#pragma mark -rightMenuButtonAction
- (void)rightDrawerButtonPress
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

#pragma mark - HorizontalScrollViewDelegate
- (NSInteger)numberOfViewsForHorizontalScrollView:(HorizontalScrollView *)scrollView
{
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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"requestComplete" object:nil];
}

@end
