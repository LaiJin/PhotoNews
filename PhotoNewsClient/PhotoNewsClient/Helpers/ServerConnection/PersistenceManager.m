//
//  PersistenceManager.m
//  PhotoNewsClient
//
//  Created by zgw on 14-2-13.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import "PersistenceManager.h"

@interface PersistenceManager ()

@property (strong, nonatomic) NSMutableArray *titlePhotoData;

@end

@implementation PersistenceManager

#pragma mark - Initialization Method
- (id)init
{
    self = [super init];
    if (self) {
        self.titlePhotoData  = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Public Method
#pragma mark - titlePhotoData operate
- (void)saveTitlePhotoData:(NSMutableArray *)titlePhotoData
{
    self.titlePhotoData = [NSMutableArray arrayWithArray:titlePhotoData];
    [NSKeyedArchiver archiveRootObject:self.titlePhotoData toFile:[self getTitlePhotoDataFilePath]];
}

- (NSArray *)getTitlePhotoData
{
    return _titlePhotoData;
}

- (NSArray *)unarchiveTitlePhotoData
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self getTitlePhotoDataFilePath]]) {
        self.titlePhotoData = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getTitlePhotoDataFilePath]];
        return _titlePhotoData;
    }
    return nil;
}

#pragma mark -getImageFromlocal
- (UIImage *)getImage:(NSString *)filename
{
    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", filename];
    NSData *data = [NSData dataWithContentsOfFile:filename];
    return  [UIImage imageWithData:data];
}

#pragma mark -saveImage
- (void)saveImage:(UIImage *)image filename:(NSString *)filename
{
    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", filename];
    NSData *data = UIImagePNGRepresentation(image);
    [data writeToFile:filename atomically:YES];
}


#pragma mark - Private Method

- (NSString *)getTitlePhotoDataFilePath
{
    NSString *titlePhotoDataFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                           NSUserDomainMask, YES) objectAtIndex:0];
    titlePhotoDataFilePath = [titlePhotoDataFilePath stringByAppendingPathComponent:@"titlePhotoData.plist"];
    return titlePhotoDataFilePath;
}

@end
