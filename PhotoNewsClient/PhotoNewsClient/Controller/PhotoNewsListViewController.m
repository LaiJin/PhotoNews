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
}

@end

@implementation PhotoNewsListViewController

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadPhotoNewsTableView)
                                                     name:@"parseComplete" object:nil];
        photoNewsTableView = [[PullTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped pullDownRefresh:YES pullUpLoadMore:YES];
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
    // Dispose of any resources that can be recreated.
}

- (void)reloadPhotoNewsTableView
{
    allImageNews = [[LibraryAPI sharedInstance] getImageNewsData];
    [photoNewsTableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [allImageNews count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
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
    return 120.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView
{
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView
{
    
}

@end
