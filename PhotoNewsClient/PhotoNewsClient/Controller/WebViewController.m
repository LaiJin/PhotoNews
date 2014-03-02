//
//  WebViewController.m
//  PhotoNewsClient
//
//  Created by zgw on 14-2-27.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate, UIScrollViewDelegate>

@end

@implementation WebViewController

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIWebView *imageNewsWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [imageNewsWebView setScalesPageToFit:NO];
//    [imageNewsWebView.scrollView setShowsHorizontalScrollIndicator:NO];
////    [imageNewsWebView.scrollView setContentSize:CGSizeMake(0, 0)];
////    [imageNewsWebView.scrollView setAlwaysBounceVertical:YES];
    [self.view addSubview:imageNewsWebView];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://192.168.1.102:3000/image_upload/image_show_view"]];
    [imageNewsWebView loadRequest:request];
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

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

@end
