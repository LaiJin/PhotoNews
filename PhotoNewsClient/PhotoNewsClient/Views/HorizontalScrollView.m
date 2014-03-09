//
//  HorizontalScrollView.m
//  PhotoNewsClient
//
//  Created by zgw on 14-2-14.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import "HorizontalScrollView.h"

@interface HorizontalScrollView ()

@property (strong, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) NSInteger totalViewsCount;

@end

#define kToolbarHeight 64.0

@implementation HorizontalScrollView

#pragma mark -Initialization Method
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

#pragma mark -Overwrite Method
- (void)didMoveToSuperview
{
    [self reload];
}

- (void)setTotalPagesCount:(NSInteger (^)(void))totalPagesCount
{
    _totalViewsCount = totalPagesCount();
    if (_totalViewsCount >= 0) {
        [self reload];
    }
}

#pragma mark - Public Methods
#pragma mark -reloadScrollView
- (void)reload
{
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    [self addShownViewsOnScrollView];
}

- (id)initWithFrame:(CGRect)frame barButtonTarget:(id)target
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureScrollView];
    }
    return self;
}

#pragma mark - Private Methods
#pragma mark -addShowViewsOnScrollView Method
- (void)addShownViewsOnScrollView
{
    if (!self.fetchViewAtIndex) return;
    NSInteger counter = 0;
    self.scrollView.contentSize = CGSizeMake(_totalViewsCount * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame) - 64.0);
    for (int i = 0 ; i < _totalViewsCount; i++) {
        UITapGestureRecognizer *tabGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTapped:)];
        
        UIView *view = self.fetchViewAtIndex(i, self);
        CGRect rightRect = view.frame;
        rightRect.origin = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (counter ++), -64.0);
        view.frame = rightRect;
        view.tag = i;
        [view addGestureRecognizer:tabGestureRecognizer];
        [self.scrollView addSubview:view];
    }
}

- (void)showIndexView:(NSInteger)index
{
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.scrollView.frame) * index, -64.0) animated:NO];
}

#pragma mark -configureScrollView
- (void)configureScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kToolbarHeight, self.bounds.size.width, self.bounds.size.height - kToolbarHeight)];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator   = NO;
    self.scrollView.backgroundColor = [UIColor grayColor];
    self.scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];
}

- (void)scrollViewTapped:(UITapGestureRecognizer *)gesture
{
    if (self.tapAction) {
        self.tapAction(gesture.view.tag);
    }
}

@end
