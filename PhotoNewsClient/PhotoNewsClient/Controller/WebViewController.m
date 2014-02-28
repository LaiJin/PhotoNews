//
//  WebViewController.m
//  PhotoNewsClient
//
//  Created by zgw on 14-2-27.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

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
    [self.view addSubview:imageNewsWebView];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://0.0.0.0:3000/image_upload/image_show_view"]];
    [imageNewsWebView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
