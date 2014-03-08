//
//  TitlePhoto.h
//  PhotoNewsClient
//
//  Created by zgw on 14-3-8.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TitlePhoto : NSObject <NSCoding>

@property (strong, nonatomic) NSNumber *title_photo_id;
@property (strong, nonatomic) NSNumber *photo_file_size;

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *synopsis;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *photo_content_type;
@property (strong, nonatomic) NSString *photo_file_name;

@property (strong, nonatomic) NSDate   *created_at;
@property (strong, nonatomic) NSDate   *updated_at;
@property (strong, nonatomic) NSDate   *photo_updated_at;

@end
