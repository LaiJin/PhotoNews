//
//  WebViewController.m
//  PhotoNewsClient
//
//  Created by zgw on 14-2-27.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import "WebViewController.h"
#import "LibraryAPI.h"
#import "TitlePhoto.h"

@interface WebViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *detailNewsWeb;

@end

@implementation WebViewController

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(requestWeb:)
                                                     name:@"viewTap"
                                                   object:nil];
        self.detailNewsWeb = [[UIWebView alloc] initWithFrame:self.view.bounds];
        [self.detailNewsWeb setDelegate:self];
        [self.view addSubview:_detailNewsWeb];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Notification Method
- (void)requestWeb:(NSNotification *)notification
{
    NSArray *titlePhotos = [[LibraryAPI sharedInstance] getTitlePhotoData];
    NSInteger index = [notification.userInfo[@"viewIndex"] integerValue];
    TitlePhoto *indexTitlePhoto = titlePhotos[index];
    NSString *url = [NSString stringWithFormat:@"http://192.168.1.102:3000/detail_photo_news?title_photo_id=%@", indexTitlePhoto.title_photo_id];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [self.detailNewsWeb loadRequest:request];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请求失败" message:@"请求服务器失败!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}

#pragma mark - Dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"viewTap" object:nil];
}


@end
