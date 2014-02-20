//
//  HorizontalScrollView.h
//  PhotoNewsClient
//
//  Created by zgw on 14-2-14.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HorizontalScrollView : UIView

@property (nonatomic, readonly) UIScrollView *scrollView;
@property (nonatomic, copy) NSInteger (^totalPagesCount)(void);
@property (nonatomic, copy) UIView *(^fetchViewAtIndex)(NSInteger viewIndex, HorizontalScrollView *scrollVivew);

- (id)initWithFrame:(CGRect)frame barButtonTarget:(id)target;

- (void)showIndexView:(NSInteger)index;

@end
