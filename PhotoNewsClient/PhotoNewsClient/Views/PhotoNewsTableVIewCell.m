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
@property (strong, nonatomic) UILabel *newsLabel;

@end

@implementation PhotoNewsTableVIewCell
@synthesize imageView = _imageView, newsLabel = _newsLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageView = [[EGOImageView alloc] initWithPlaceholderImage: [UIImage imageNamed:@"placeholder.png"]];
        self.imageView.frame = CGRectMake(10.0, 10.0, 80.0, 100.0);
        self.newsLabel = [[UILabel alloc] initWithFrame:CGRectMake(100.0, 10.0, 200.0, 100.0)];
        [self.newsLabel setFont:[UIFont systemFontOfSize:14.0]];
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.newsLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

#pragma mark - Public Methods
- (void)setImageViewUrl:(NSString *)url
{
    [self.imageView setImageURL:[NSURL URLWithString:url]];
}

- (void)configNewsLabelWithTitle:(NSString *)title synopsis:(NSString *)synopsis
{
    NSString *text = [NSString stringWithFormat:@"  %@\n\n  %@", title, synopsis];
    [self.newsLabel setNumberOfLines:6];
    [self.newsLabel setText:text];
}

@end
