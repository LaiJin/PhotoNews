//
//  ImageNews.h
//  PhotoNewsClient
//
//  Created by zgw on 14-2-13.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageNews : NSObject<NSCoding>


@property(strong, nonatomic) NSNumber *imageNews_id;
@property(strong, nonatomic) NSNumber *image_file_size;

@property(strong, nonatomic) NSString *content;
@property(strong, nonatomic) NSString *image_url;
@property(strong, nonatomic) NSString *image_content_type;
@property(strong, nonatomic) NSString *image_file_name;

@property(strong, nonatomic) NSDate   *created_at;
@property(strong, nonatomic) NSDate   *updated_at;
@property(strong, nonatomic) NSDate   *image_updated_at;


@end
