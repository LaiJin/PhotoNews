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
    LibraryAPI  *libraryApI;
}

@end

@implementation PhotoNewsShowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        photoNewsShowView = [[PhotoNewsShowView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 20.0, self.view.frame.size.width, self.view.frame.size.height - 80.0)];
        self.view = photoNewsShowView;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    libraryApI = [[LibraryAPI alloc] init];
    [libraryApI getImageNews];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
