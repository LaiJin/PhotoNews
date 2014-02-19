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

#define kDenominator 2.5
#define kSpace 20.0

@implementation PhotoNewsShowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

#pragma mark - Public Method
- (id)initWithFrame:(CGRect)frame newsImageUrl:(NSString *)newsImageUrl newsContent:(NSString *)newsContent
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureImageView];
        [self configureTextFiled:newsContent];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DownloadImageNotification" object:self userInfo:@{@"imageView":_imageView,@"imageUrl":newsImageUrl}];
    }
    return self;
}

#pragma mark - Private Methods
#pragma mark -configureImageView
- (void)configureImageView
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height / kDenominator )];
    self.imageView.backgroundColor = [UIColor redColor];
    [self addSubview:_imageView];
}

#pragma mark -configureTextFiled
- (void)configureTextFiled:(NSString *)newsContent
{
    self.newsInfoText = [[UITextField alloc] initWithFrame:CGRectMake(0, self.frame.size.height / kDenominator + kSpace, self.frame.size.width, self.frame.size.height / kDenominator)];
    self.newsInfoText.text = newsContent;
    self.newsInfoText.borderStyle = UITextBorderStyleRoundedRect;
    self.newsInfoText.textAlignment = NSTextAlignmentCenter;
    [self.newsInfoText setEnabled:NO];
    [self addSubview:_newsInfoText];
}

@end
