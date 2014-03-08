//
//  TitlePhoto.m
//  PhotoNewsClient
//
//  Created by zgw on 14-3-8.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import "TitlePhoto.h"

@implementation TitlePhoto

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title_photo_id forKey:@"title_photo_id"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.synopsis forKey:@"synopsis"];
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:self.created_at forKey:@"created_at"];
    [aCoder encodeObject:self.updated_at forKey:@"updated_at"];
    [aCoder encodeObject:self.photo_file_name forKey:@"photo_file_name"];
    [aCoder encodeObject:self.photo_content_type forKey:@"photo_content_type"];
    [aCoder encodeObject:self.photo_file_size forKey:@"photo_file_size"];
    [aCoder encodeObject:self.photo_updated_at forKey:@"photo_updated_at"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.title_photo_id = [aDecoder decodeObjectForKey:@"title_photo_id"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.synopsis = [aDecoder decodeObjectForKey:@"synopsis"];
        self.url = [aDecoder decodeObjectForKey:@"url"];
        self.created_at = [aDecoder decodeObjectForKey:@"created_at"];
        self.updated_at = [aDecoder decodeObjectForKey:@"updated_at"];
        self.photo_file_name = [aDecoder decodeObjectForKey:@"photo_file_name"];
        self.photo_content_type = [aDecoder decodeObjectForKey:@"photo_content_type"];
        self.photo_file_size = [aDecoder decodeObjectForKey:@"photo_file_size"];
        self.photo_updated_at = [aDecoder decodeObjectForKey:@"photo_updated_at"];
    }
    return self;
}


@end
