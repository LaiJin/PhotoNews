//
//  HorizontalScrollView.m
//  PhotoNewsClient
//
//  Created by zgw on 14-2-14.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import "HorizontalScrollView.h"

@interface HorizontalScrollView ()<UIScrollViewDelegate>

@property(strong, nonatomic)UIScrollView *scrollView;

@end

@implementation HorizontalScrollView

#pragma mark -
#pragma mark -Initialization Method
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizesSubviews = YES;
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.autoresizingMask = 0xFF;
        self.scrollView.contentMode = UIViewContentModeCenter;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator   = NO;
        self.scrollView.backgroundColor = [UIColor blueColor];
        self.scrollView.delegate = self;
//        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        self.scrollView.pagingEnabled = YES;// 实现分页显示''''
        [self addSubview:_scrollView];
    }
    return self;
}

#pragma mark - Overwrite Method
- (void)didMoveToSuperview
{
    [self reload];
}


#pragma mark - Public Methods
#pragma mark -reloadScrollView
- (void)reload
{
    if (self.delegate == nil) return;
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    NSInteger counter = 0;
    NSInteger viewsCount = [self.delegate numberOfViewsForHorizontalScrollView:self];
    self.scrollView.contentSize = CGSizeMake(viewsCount * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));// 控制显示页面数量
    for (int i = 0 ; i < viewsCount; i++) {
        
        UIView *view = [self.delegate horziontalScrollView:self viewAtIndex:i];
        CGRect rightRect = view.frame;
        rightRect.origin = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (counter ++), 0);
        view.frame = rightRect;
        [self.scrollView addSubview:view];
    }
//    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0)];
}

//#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    //手指离开屏幕后ScrollView还会继续滚动一段时间只到停止
//    NSLog(@"结束滚动后缓冲滚动彻底结束时调用");
//}
//
//-(void) scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
//{
//    
//    NSLog(@"结束滚动后开始缓冲滚动时调用");
//}
//
//-(void)scrollViewDidScroll:(UIScrollView*)scrollView
//
//{
//    //页面滚动时调用，设置当前页面的ID
//    NSLog(@"视图滚动中X轴坐标%f",scrollView.contentOffset.x);
//    NSLog(@"视图滚动中X轴坐标%f",scrollView.contentOffset.y);
//}
//
//-(void)scrollViewWillBeginDragging:(UIScrollView*)scrollView
//{
//    NSLog(@"滚动视图开始滚动，它只调用一次");
//}
//
//-(void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
//{
//    NSLog(@"滚动视图结束滚动，它只调用一次");
//    
//}


@end
