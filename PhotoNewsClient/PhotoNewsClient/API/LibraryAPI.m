//
//  LibraryAPI.m
//  PhotoNewsClient
//
//  Created by zgw on 14-2-13.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import "LibraryAPI.h"
#import <SystemConfiguration/SCNetworkReachability.h>
#import <netinet/in.h>
#import "ASIHTTPRequest.h"
#import "HTTPClient.h"
#import "PersistenceManager.h"


@interface LibraryAPI ()<ASIHTTPRequestDelegate>
{
    HTTPClient  *httpClient;
    PersistenceManager *persistenceManager;
}

@end

@implementation LibraryAPI

- (id)init
{
    self = [super init];
    if (self) {
        httpClient = [[HTTPClient alloc] init];
        persistenceManager = [[PersistenceManager alloc] init];
    }
    return self;
}

#pragma mark - Public Method

+ (LibraryAPI *)sharedInstance
{
    static LibraryAPI *singleton;
	static dispatch_once_t onceToken;
	
	dispatch_once(&onceToken, ^{
		singleton = [[LibraryAPI alloc] init];
	});
	return singleton;
}

- (void)getImageNews
{
    if ([self isNetworkReachable]) {
        [httpClient getRequest:@"http://0.0.0.0:3000/image_news_data.json" requestDelegateImplementor:self];
        return;
    }
    NSLog(@"请检查网络是否连接!");
}


#pragma mark - Private Method

#pragma mark -isNetworkReachable
- (BOOL)isNetworkReachable
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
      return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

#pragma mark - ASIHTTPRequestDelegate

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *responseData = [request responseData];
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
    NSArray *imageNewsData = [jsonDictionary objectForKey:@"data"];
    NSLog(@"%@", imageNewsData);
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
//    NSError *error = [request error];
    if ([self isNetworkReachable]) {
        NSLog(@"请求服务器超时!");
        return;
    }
    NSLog(@"请检查网络是否连接!");
}

@end
