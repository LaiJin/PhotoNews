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

- (void)getRequest:(NSString *)url  requestDelegateImplementor :(id)implementor
{
    NSURL *requestUrl = [NSURL URLWithString:url];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:requestUrl];
    [request setDelegate:implementor];
    [request startAsynchronous];
}

@end
