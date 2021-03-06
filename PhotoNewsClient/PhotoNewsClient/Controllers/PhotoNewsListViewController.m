//
//  PhotoNewsListViewController.m
//  PhotoNewsClient
//
//  Created by zgw on 14-2-17.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import "PhotoNewsListViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "PullTableView.h"
#import "LibraryAPI.h"
#import "TitlePhoto.h"
#import "PhotoNewsTableVIewCell.h"

@interface PhotoNewsListViewController ()<UITableViewDataSource, UITableViewDelegate ,PullTableViewDelegate>
{
    PullTableView *photoNewsTableView;
    NSArray *titlePhotos;
    NSInteger displayTitleNewsCount;
    NSInteger count;
}

@end

#define kFirstShowNews 6
#define kRowHeight 120.0f
#define kRowsInSection 1
#define kHeightForHeader 5.0f
#define kHeightForFooter 5.0f

@implementation PhotoNewsListViewController

- (id)init
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:[UIColor whiteColor]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadPhotoNewsTableView:)
                                                     name:@"requestComplete" object:nil];
        displayTitleNewsCount = kFirstShowNews;
        [self addTableView];
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)reloadPhotoNewsTableView:(NSNotification *)notification
{
    titlePhotos = [[LibraryAPI sharedInstance] getTitlePhotoData];
    count = titlePhotos.count - titlePhotos.count % kFirstShowNews;
    displayTitleNewsCount = kFirstShowNews;
    
    [photoNewsTableView reloadData];
    
    [notification.userInfo[@"alertView"] show];
    
    if(photoNewsTableView.pullTableIsRefreshing) {
        [photoNewsTableView setPullLastRefreshDate:[NSDate date]];
        [photoNewsTableView setPullTableIsRefreshing:NO];
    }
}

#pragma mark - Private Methods

- (void)addTableView
{
    CGRect frame = CGRectMake(0, 20.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    photoNewsTableView = [[PullTableView alloc] initWithFrame:frame
                                                        style:UITableViewStyleGrouped
                                              pullDownRefresh:YES
                                               pullUpLoadMore:YES];
    photoNewsTableView.pullDelegate = self;
    photoNewsTableView.delegate = self;
    photoNewsTableView.dataSource = self;
    photoNewsTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:photoNewsTableView];
}

- (void)loadModePhotoNewsData
{
    [self calculateDisplayTitleNewsCount];
    [photoNewsTableView reloadData];
    [photoNewsTableView setPullTableIsLoadingMore:NO];
}

- (void)calculateDisplayTitleNewsCount
{
    if (titlePhotos.count <= displayTitleNewsCount) {
        displayTitleNewsCount = titlePhotos.count;
        return;
    }
    if (count <= displayTitleNewsCount) {
        displayTitleNewsCount = titlePhotos.count;
        return;
    }
    displayTitleNewsCount += kFirstShowNews;
}

- (void)refreshTableView
{
    [[LibraryAPI sharedInstance] requestServer];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  titlePhotos.count < displayTitleNewsCount  ? titlePhotos.count : displayTitleNewsCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kRowsInSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *photoNewsCellIdentifier = @"photoNewsCellIdentifier";
    PhotoNewsTableVIewCell *cell = [tableView dequeueReusableCellWithIdentifier:photoNewsCellIdentifier];
    if (cell == nil) {
        cell = [[PhotoNewsTableVIewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:photoNewsCellIdentifier];
    }
    TitlePhoto *indexTitlePhoto = titlePhotos[indexPath.section];
    [cell configNewsLabelWithTitle:indexTitlePhoto.title synopsis:indexTitlePhoto.synopsis];
    [cell setImageViewUrl:indexTitlePhoto.url];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kRowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kHeightForHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kHeightForFooter;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showSelectView" object:nil userInfo:@{@"index": [NSNumber numberWithInteger:indexPath.section]}];
}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView
{
    [self performSelector:@selector(refreshTableView) withObject:nil afterDelay:3.0f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView
{
    [self performSelector:@selector(loadModePhotoNewsData) withObject:nil afterDelay:3.0f];
}

#pragma mark - Dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"requestComplete" object:nil];
}

@end
