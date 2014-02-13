//
//  HTTPClient.h
//  PhotoNewsClient
//
//  Created by zgw on 14-2-13.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPClient : NSObject

- (void)getRequest:(NSString *)url  requestDelegateImplementor :(id)implementor;

@end
