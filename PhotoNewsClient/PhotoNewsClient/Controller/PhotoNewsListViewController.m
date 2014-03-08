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
#define kHeightForHeader 15.0f
#define kHeightForFooter 5.0f

@implementation PhotoNewsListViewController

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadPhotoNewsTableView:)
                                                     name:@"requestComplete" object:nil];
        displayTitleNewsCount = kFirstShowNews;
        photoNewsTableView = [[PullTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped pullDownRefresh:YES pullUpLoadMore:YES];
        photoNewsTableView.pullDelegate = self;
        photoNewsTableView.delegate = self;
        photoNewsTableView.dataSource = self;
        [self.view addSubview:photoNewsTableView];
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
- (void)loadModePhotoNewsData
{
    if (titlePhotos.count <= displayTitleNewsCount)
        displayTitleNewsCount = titlePhotos.count;
    else if (count <= displayTitleNewsCount)
        displayTitleNewsCount = titlePhotos.count;
    else
        displayTitleNewsCount += kFirstShowNews;
    [photoNewsTableView reloadData];
    [photoNewsTableView setPullTableIsLoadingMore:NO];
}

- (void)refreshTableView
{
    [[LibraryAPI sharedInstance] requestServer];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  titlePhotos.count == 0 ? titlePhotos.count : displayTitleNewsCount;
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
    [cell setTextFiledContent:indexTitlePhoto.title];
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
