//
//  PhotoNewsShowViewController.m
//  PhotoNewsClient
//
//  Created by xyooyy on 14-2-11.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import "PhotoNewsShowViewController.h"
#import "LibraryAPI.h"
#import "HorizontalScrollView.h"
#import "ImageNews.h"

@interface PhotoNewsShowViewController ()<HorizontalScrollViewDelegate>
{
    HorizontalScrollView *scrollView;
    NSArray *allImageNews;
}

@end

@implementation PhotoNewsShowViewController

- (id)init
{
    self = [super init];
    if (self) {
        [[LibraryAPI sharedInstance] requestServer];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setAllImageNews)
                                              name:@"parseComplete" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     NSLog(@"%@", allImageNews);
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"%@", allImageNews);
}

- (void)setAllImageNews
{
    allImageNews = [[LibraryAPI sharedInstance] getImageNewsData];
    scrollView = [[HorizontalScrollView alloc] initWithFrame:self.view.frame];
    scrollView.delegate = self;
    self.view = scrollView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - HorizontalScrollViewDelegate
- (NSInteger)numberOfViewsForHorizontalScrollView:(HorizontalScrollView *)scrollView
{
    NSLog(@"%i", [allImageNews count]);
    return [allImageNews count];
}

- (UIView *)horziontalScrollView:(HorizontalScrollView *)scrollView viewAtIndex:(int)index
{
    ImageNews *indexImageNews = [allImageNews objectAtIndex:index];
    CGRect viewFrame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 20.0, self.view.frame.size.width, self.view.frame.size.height - 80.0);
    return [[PhotoNewsShowView alloc] initWithFrame:viewFrame newsImageUrl:indexImageNews.image_url newsContent:indexImageNews.content];
}

#pragma mark - Dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"parseComplete" object:nil];
}

@end
