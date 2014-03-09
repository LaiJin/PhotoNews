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
@property (strong, nonatomic)  UITextView *newsInfoText;

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
- (id)initWithFrame:(CGRect)frame imageUrl:(NSString *)url title:(NSString *)title synopsis:(NSString *)synopsis
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self configureImageView];
        [self configureNewsInfoTextWithTitle:title newsSynopsis:synopsis];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DownloadImageNotification" object:self userInfo:@{@"imageView":_imageView,@"imageUrl":url}];
    }
    return self;
}

#pragma mark - Private Methods
#pragma mark -configureView
- (void)configureImageView
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   self.frame.size.width,
                                                                   self.frame.size.height / kDenominator )];
    self.imageView.backgroundColor = [UIColor redColor];
    [self addSubview:_imageView];
}


- (void)configureNewsInfoTextWithTitle:(NSString *)title newsSynopsis:(NSString *)sysopsis
{
    self.newsInfoText = [[UITextView alloc] initWithFrame:CGRectMake(0, (self.frame.size.height / kDenominator), self.frame.size.width, self.frame.size.height / kDenominator)];
    NSString *text = [NSString stringWithFormat:@"\n  %@\n\n  %@", title, sysopsis];
    [self.newsInfoText setText:text];
    [self.newsInfoText setFont:[UIFont systemFontOfSize:14.0]];
//    [self.newsInfoText.layer setCornerRadius:10];//控制圆角
    [self.newsInfoText setEditable:NO];
    [self.newsInfoText setSelectable:NO];
    [self addSubview:_newsInfoText];
}

@end
