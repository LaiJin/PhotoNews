//
//  HorizontalScrollView.h
//  PhotoNewsClient
//
//  Created by zgw on 14-2-14.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HorizontalScrollView;

@protocol HorizontalScrollViewDelegate <NSObject>

- (NSInteger)numberOfViewsForHorizontalScrollView:(HorizontalScrollView *)scrollView;

- (UIView *)horziontalScrollView:(HorizontalScrollView *)scrollView viewAtIndex:(int)index;

@end

@interface HorizontalScrollView : UIView

//@property(nonatomic, readonly)UIScrollView *scrollView;
@property(weak,  nonatomic)id<HorizontalScrollViewDelegate>delegate;

- (void)reload;

@end
