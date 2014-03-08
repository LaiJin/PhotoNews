//
//  PersistenceManager.h
//  PhotoNewsClient
//
//  Created by zgw on 14-2-13.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersistenceManager : NSObject

- (void)saveTitlePhotoData:(NSMutableArray *)titlePhotoData;

- (NSArray *)getTitlePhotoData;

- (NSArray *)unarchiveTitlePhotoData;

- (UIImage *)getImage:(NSString *)filename;

- (void)saveImage:(UIImage *)image filename:(NSString *)filename;

@end
