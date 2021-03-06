
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
#import "TitlePhoto.h"
#import "PhotoNewsShowView.h"
#import "UIViewController+MMDrawerController.h"
#import "WebViewController.h"
#import "MMDrawerBarButtonItem.h"

@interface PhotoNewsShowViewController ()
{
    HorizontalScrollView *horizontalScrollView;
}

@end

@implementation PhotoNewsShowViewController

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadScrollView:)
                                                     name:@"requestComplete" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSelectView:)
                                                     name:@"showSelectView" object:nil];
        
        MMDrawerBarButtonItem *leftButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftButtonPress)];
        self.navigationItem.leftBarButtonItem = leftButton;

        [[LibraryAPI sharedInstance] requestServer];
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        horizontalScrollView = [[HorizontalScrollView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview: horizontalScrollView];
        
        UIViewController *rightViewController = [[WebViewController alloc] init];
        [self tapAction:rightViewController];
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
    /*控制不会在toolbar上通过左右滑动手势达到切换视图的目的, 放在viewDidLoad方法里达不到效果*/
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Private Methods

- (void)reloadScrollView:(NSNotification *)notification
{
    NSArray * titlePhotos = [[LibraryAPI sharedInstance] getTitlePhotoData];
    
    horizontalScrollView.fetchViewAtIndex = ^UIView *(NSInteger pageIndex, HorizontalScrollView *scrollView){
        TitlePhoto *indexTitlePhoto = [titlePhotos objectAtIndex:pageIndex];
        return [[PhotoNewsShowView alloc] initWithFrame:CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height) imageUrl:indexTitlePhoto.url title:indexTitlePhoto.title synopsis:indexTitlePhoto.synopsis];
    };
    
    horizontalScrollView.totalPagesCount = ^NSInteger(void){
        return titlePhotos.count;
    };
    
    [notification.userInfo[@"alertView"] show];
}

- (void)showSelectView:(NSNotification *)notification
{
    [horizontalScrollView showIndexView: [notification.userInfo[@"index"] integerValue]];
}


- (void)tapAction:(UIViewController *)rightViewController
{
    __weak typeof(self) weakSelf = self;
    horizontalScrollView.tapAction = ^(NSInteger viewIndex) {
        [weakSelf.navigationController pushViewController:rightViewController animated:YES];
        
        NSNumber *index = [NSNumber numberWithInteger:viewIndex];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"viewTap"
                                                            object:nil
                                                          userInfo:@{@"viewIndex": index}];
    };
}

#pragma mark -leftMenuButtonAction
- (void)leftButtonPress
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - Dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"requestComplete" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"showSelectView" object:nil];
}

@end
