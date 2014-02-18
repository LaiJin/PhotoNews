//
//  PhotoNewsTableVIewCell.m
//  PhotoNewsClient
//
//  Created by zgw on 14-2-17.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import "PhotoNewsTableVIewCell.h"
#import "EGOImageView.h"

@interface PhotoNewsTableVIewCell ()

@property(strong, nonatomic) EGOImageView *imageView;
@property(strong, nonatomic) UITextField *textFiled;

@end

@implementation PhotoNewsTableVIewCell
/*
 * 必须要加 生成 set 和 get 方法 ，不加会报 
 *[PhotoNewsTableVIewCell setImageView:]: unrecognized selector sent to instance 0xa06da10 错误
 */
@synthesize imageView =_imageView, textFiled = _textFiled;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imageView = [[EGOImageView alloc] initWithPlaceholderImage: [UIImage imageNamed:@"loading.png"]];
        self.imageView.frame = CGRectMake(10.0, 10.0, 80.0, 100.0);
        self.textFiled = [[UITextField alloc] initWithFrame:CGRectMake(100.0, 10.0, 200.0, 36.0)];
        [self.textFiled setEnabled:NO];
        [self.contentView addSubview: self.imageView];
        [self.contentView addSubview:self.textFiled];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Public Methods
#pragma mark -setImageViewUrl
- (void)setImageViewUrl:(NSString *)url
{
    self.imageView.imageURL = [NSURL URLWithString:url];
}

#pragma mark -setTextFiledContent
- (void)setTextFiledContent:(NSString *)content
{
    self.textFiled.text = content;
}

@end
