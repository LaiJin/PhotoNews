//
//  PhotoNewsShowViewController.m
//  PhotoNewsClient
//
//  Created by xyooyy on 14-2-11.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import "PhotoNewsShowViewController.h"
#import "LibraryAPI.h"

@interface PhotoNewsShowViewController ()
{
    NSArray *allImageNews;
}

@end

@implementation PhotoNewsShowViewController

- (id)init
{
    self = [super init];
    if (self) {
        photoNewsShowView = [[PhotoNewsShowView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 20.0, self.view.frame.size.width, self.view.frame.size.height - 80.0)];
        self.view = photoNewsShowView;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"parseComplete" object:nil];
}

@end
