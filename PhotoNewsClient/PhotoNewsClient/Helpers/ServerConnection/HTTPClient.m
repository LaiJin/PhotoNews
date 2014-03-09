//
//  HTTPClient.m
//  PhotoNewsClient
//
//  Created by zgw on 14-2-13.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import "HTTPClient.h"
#import "ASIHTTPRequest.h"

@implementation HTTPClient

#pragma mark - Public Method

- (void)getRequest:(NSString *)url requestDelegateImplementor:(id)delegateImplementor
{
    NSURL *requestUrl = [NSURL URLWithString:url];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:requestUrl];
    [request setDelegate:delegateImplementor];
    [request startAsynchronous];
}

- (UIImage*)downloadImage:(NSString*)url
{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

@end
