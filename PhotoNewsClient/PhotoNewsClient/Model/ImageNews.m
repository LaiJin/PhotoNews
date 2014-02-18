//
//  ImageNews.m
//  PhotoNewsClient
//
//  Created by zgw on 14-2-13.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import "ImageNews.h"

@implementation ImageNews

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.image_url forKey:@"image_url"];
    [aCoder encodeObject:self.imageNews_id forKey:@"imageNews_id"];
    [aCoder encodeObject:self.content forKey:@"imageNews_content"];
    [aCoder encodeObject:self.created_at forKey:@"imageNews_created_at"];
    [aCoder encodeObject:self.updated_at forKey:@"imageNews_updated_at"];
    [aCoder encodeObject:self.image_file_name forKey:@"image_file_name"];
    [aCoder encodeObject:self.image_file_size forKey:@"image_file_size"];
    [aCoder encodeObject:self.image_updated_at forKey:@"image_updated_at"];
    [aCoder encodeObject:self.image_content_type forKey:@"image_content_type"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.image_url = [aDecoder decodeObjectForKey:@"image_url"];
        self.imageNews_id = [aDecoder decodeObjectForKey:@"imageNews_id"];
        self.content = [aDecoder decodeObjectForKey:@"imageNews_content"];
        self.created_at = [aDecoder decodeObjectForKey:@"imageNews_created_at"];
        self.updated_at = [aDecoder decodeObjectForKey:@"imageNews_updated_at"];
        self.image_file_name = [aDecoder decodeObjectForKey:@"image_file_name"];
        self.image_file_size = [aDecoder decodeObjectForKey:@"image_file_size"];
        self.image_updated_at = [aDecoder decodeObjectForKey:@"image_updated_at"];
        self.image_content_type = [aDecoder decodeObjectForKey:@"image_content_type"];
    }
    return self;
}

@end
