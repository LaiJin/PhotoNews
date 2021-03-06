//
//  LibraryAPI.m
//  PhotoNewsClient
//
//  Created by zgw on 14-2-13.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import "LibraryAPI.h"
#import "SystemConfiguration/SCNetworkReachability.h"
#import "netinet/in.h"
#import "ASIHTTPRequest.h"
#import "HTTPClient.h"
#import "PersistenceManager.h"
#import "TitlePhoto.h"
#import "OCMapper.h"


@interface LibraryAPI ()<ASIHTTPRequestDelegate>
{
    HTTPClient  *httpClient;
    PersistenceManager *persistenceManager;
    BOOL isRequestSuccess;
}

@end

@implementation LibraryAPI

- (id)init
{
    self = [super init];
    if (self) {
        httpClient = [[HTTPClient alloc] init];
        persistenceManager = [[PersistenceManager alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadImage:) name:@"DownloadImageNotification" object:nil];
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

- (void)requestServer
{
//    if ([self isNetworkReachable]) {
        [httpClient getRequest:@"http://192.168.1.102:3000/title_photo_data.json" requestDelegateImplementor:self];
//        return;
//    }
//    NSLog(@"请检查网络是否连接!");ZGW  
}

- (NSArray *)getTitlePhotoData
{
    if ([self isNetworkReachable] && isRequestSuccess) {
        return [persistenceManager getTitlePhotoData];
    }
    return  [persistenceManager unarchiveTitlePhotoData];
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
    
    if (!didRetrieveFlags) return NO;
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

#pragma mark -downloadImage
- (void)downloadImage:(NSNotification *)notification
{
    UIImageView *imgaeView = notification.userInfo[@"imageView"];
    NSString *imageUrl = notification.userInfo[@"imageUrl"];
    imgaeView.image = [persistenceManager getImage:[imageUrl lastPathComponent]];
    if (imgaeView.image == nil) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *imgae = [httpClient downloadImage:imageUrl];
            dispatch_sync(dispatch_get_main_queue(), ^{
                imgaeView.image = imgae;
                [persistenceManager saveImage:imgae filename:[imageUrl lastPathComponent]];
            });
        });
    }
}

- (NSString *)getMessageContent
{
    if (![self isNetworkReachable]) {
        return @"请检查网络是否连接!";
    }
    return  @"请求服务器失败!";
    
}

#pragma mark - ASIHTTPRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData  *responseData = [request responseData];
    NSMutableArray *jsonArray = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
    NSMutableArray *titlePhotoData = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *titlePhoto in jsonArray) {
        TitlePhoto *indexTitlePhoto = [TitlePhoto objectFromDictionary:titlePhoto];
        [titlePhotoData addObject:indexTitlePhoto];
    }
    [persistenceManager saveTitlePhotoData:titlePhotoData];
    isRequestSuccess = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"requestComplete" object:nil userInfo:nil];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    isRequestSuccess = NO;
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请求失败" message:[self getMessageContent] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"requestComplete" object:nil userInfo:@{@"alertView": alertView}];
}



#pragma mark -
#pragma mark Dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
