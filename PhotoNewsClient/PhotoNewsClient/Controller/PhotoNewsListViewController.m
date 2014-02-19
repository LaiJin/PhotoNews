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
#import "ImageNews.h"
#import "PhotoNewsTableVIewCell.h"

@interface PhotoNewsListViewController ()<UITableViewDataSource, UITableViewDelegate ,PullTableViewDelegate>
{
    PullTableView *photoNewsTableView;
    NSArray *allImageNews;
    NSInteger displayNewsCount;
    NSInteger count;
}

@end

#define kFirstShowNews 6
#define kRowHeight 120.0f
#define kRowsInSection 1

@implementation PhotoNewsListViewController

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadPhotoNewsTableView)
                                                     name:@"parseComplete" object:nil];
        displayNewsCount = kFirstShowNews;
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

- (void)reloadPhotoNewsTableView
{
    allImageNews = [[LibraryAPI sharedInstance] getImageNewsData];
    count = allImageNews.count - allImageNews.count % kFirstShowNews;
    [photoNewsTableView reloadData];
    if(photoNewsTableView.pullTableIsRefreshing) {
        [photoNewsTableView setPullLastRefreshDate:[NSDate date]];
        [photoNewsTableView setPullTableIsRefreshing:NO];
    }
}

#pragma mark - Private Methods
- (void)loadModePhotoNewsData
{
    if (allImageNews.count <= displayNewsCount)
        displayNewsCount = allImageNews.count;
    else if (count == displayNewsCount)
        displayNewsCount = allImageNews.count;
    else
        displayNewsCount += kFirstShowNews;
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
    return  allImageNews.count == 0 ? allImageNews.count : displayNewsCount;
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
    ImageNews *indexImageNews = allImageNews[indexPath.section];
    [cell setTextFiledContent:indexImageNews.content];
    [cell setImageViewUrl:indexImageNews.image_url];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView
{
//    [self refreshTableView];
    [self performSelector:@selector(refreshTableView) withObject:nil afterDelay:3.0f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView
{
    [self performSelector:@selector(loadModePhotoNewsData) withObject:nil afterDelay:3.0f];
}

@end
