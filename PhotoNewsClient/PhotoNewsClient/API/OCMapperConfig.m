//
//  OCMapperConfig.m
//  PhotoNewsClient
//
//  Created by zgw on 14-2-13.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import "OCMapperConfig.h"
#import "InCodeMappingProvider.h"
#import "ObjectInstanceProvider.h"
#import "CommonLoggingProvider.h"
#import "ObjectMapper.h"
#import "ImageNews.h"

@implementation OCMapperConfig

+ (void)configure
{
    ObjectInstanceProvider *instanceProvider = [[ObjectInstanceProvider alloc] init];
	InCodeMappingProvider *inCodeMappingProvider = [[InCodeMappingProvider alloc] init];
//    CommonLoggingProvider *commonLoggingProvider = [[CommonLoggingProvider alloc] initWithLogLevel:LogLevelInfo];
	[[ObjectMapper sharedInstance] setInstanceProvider:instanceProvider];
	[[ObjectMapper sharedInstance] setMappingProvider:inCodeMappingProvider];
//    [[ObjectMapper sharedInstance] setLoggingProvider:commonLoggingProvider];
    [inCodeMappingProvider mapFromDictionaryKey:@"id" toPropertyKey:@"imageNews_id"forClass:[ImageNews class]];
}


@end
