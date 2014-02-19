//
//  PersistenceManager.m
//  PhotoNewsClient
//
//  Created by zgw on 14-2-13.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import "PersistenceManager.h"

@interface PersistenceManager ()

@property (strong, nonatomic) NSMutableArray *imageNewsData;

@end

@implementation PersistenceManager

#pragma mark - Initialization Method
- (id)init
{
    self = [super init];
    if (self) {
        self.imageNewsData  = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Public Method
#pragma mark -saveImageNewsData
- (void)saveImageNewsData :(NSMutableArray *)imageNewsData
{
    self.imageNewsData = [NSMutableArray arrayWithArray:imageNewsData];
    [NSKeyedArchiver archiveRootObject:self.imageNewsData toFile:[self getImageNewsDataFilePath]];
}

#pragma mark -getImageNewsData
- (NSArray *)getImageNewsData
{
    return _imageNewsData;
}

#pragma mark -unarchiveImageNewsData
- (NSArray *)unarchiveImageNewsData
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self getImageNewsDataFilePath]]) {
        self.imageNewsData = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getImageNewsDataFilePath]];
        return _imageNewsData;
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
#pragma mark -getImageNewsDataFilePath
- (NSString *)getImageNewsDataFilePath
{
    NSString *imageNewsDataFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                           NSUserDomainMask, YES) objectAtIndex:0];
    imageNewsDataFilePath = [imageNewsDataFilePath stringByAppendingPathComponent:@"imageNewsData.plist"];
    return imageNewsDataFilePath;
}

@end
