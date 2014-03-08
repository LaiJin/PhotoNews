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

@property (strong, nonatomic) EGOImageView *imageView;
@property (strong, nonatomic) UILabel *label;

@end

@implementation PhotoNewsTableVIewCell
@synthesize imageView =_imageView, label = _label;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageView = [[EGOImageView alloc] initWithPlaceholderImage: [UIImage imageNamed:@"loading.png"]];
        self.imageView.frame = CGRectMake(10.0, 10.0, 80.0, 100.0);
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(100.0, 10.0, 200.0, 100.0)];
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.label];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

#pragma mark - Public Methods
#pragma mark -setImageViewUrl
- (void)setImageViewUrl:(NSString *)url
{
    [self.imageView setImageURL:[NSURL URLWithString:url]];
}

#pragma mark -setTextFiledContent
- (void)setTextFiledContent:(NSString *)content
{
    [self.label setNumberOfLines:3];
    [self.label setText:content];
}

@end
