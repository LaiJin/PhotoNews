//
//  PhotoNewsShowView.m
//  PhotoNewsClient
//
//  Created by xyooyy on 14-2-11.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//


#import "PhotoNewsShowView.h"

@interface PhotoNewsShowView ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UITextField *newsInfoText;

@end

@implementation PhotoNewsShowView
//@synthesize imageView = _imageView, newsInfoText = _newsInfoText;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self addImageView];
//        [self addNewsInfoText];
    }
    return self;
}

#pragma mark - Public Method
- (id)initWithFrame:(CGRect)frame newsImageUrl:(NSString *)newsImageUrl newsContent:(NSString *)newsContent
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height / 2 )];
        self.imageView.backgroundColor = [UIColor redColor];
        self.newsInfoText = [[UITextField alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + self.imageView.frame.size.height + 20.0, self.frame.size.width, self.frame.size.height / 2)];
        self.newsInfoText.text = newsContent;
        self.newsInfoText.textAlignment = NSTextAlignmentCenter;
//        self.newsInfoText.backgroundColor = [UIColor blueColor];
        [self.newsInfoText setEnabled:NO];
        [self addSubview:_imageView];
        [self addSubview:_newsInfoText];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DownloadImageNotification" object:self userInfo:@{@"imageView":_imageView,@"imageUrl":newsImageUrl}];
    }
    return self;
}

@end
