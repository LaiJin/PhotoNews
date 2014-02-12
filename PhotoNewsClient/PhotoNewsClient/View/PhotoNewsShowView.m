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
@synthesize imageView = _imageView, newsInfoText = _newsInfoText;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addImageView];
        [self addNewsInfoText];
    }
    return self;
}

#pragma mark - public Method

- (void)addImageToimageView:(UIImage *)image
{
    self.imageView.image = image;
}

#pragma mark - Private Method

- (void)addImageView
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height / 2 )];
    self.imageView.backgroundColor = [UIColor redColor];
    [self addSubview:_imageView];
}

- (void)addNewsInfoText
{
    self.newsInfoText = [[UITextField alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + self.imageView.frame.size.height + 20.0, self.frame.size.width, self.frame.size.height / 2)];
    self.newsInfoText.text = @"da";
    self.newsInfoText.textAlignment = NSTextAlignmentCenter;
    self.newsInfoText.backgroundColor = [UIColor blueColor];
    [self.newsInfoText setEnabled:NO];
    [self addSubview:_newsInfoText];
}

@end
