//
//  PersistenceManager.h
//  PhotoNewsClient
//
//  Created by zgw on 14-2-13.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersistenceManager : NSObject

- (void)saveImageNewsData :(NSMutableArray *)imageNewsData;

- (NSArray *)getImageNewsData;

- (NSArray *)unarchiveImageNewsData;

@end
