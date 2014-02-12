//
//  PhotoNewsShowViewController.m
//  PhotoNewsClient
//
//  Created by xyooyy on 14-2-11.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import "PhotoNewsShowViewController.h"

@interface PhotoNewsShowViewController ()

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
    
    NSURL *url = [NSURL URLWithString: @"http://0.0.0.0:3000/image_news_data.json"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}


#pragma mark -
#pragma mark ASIHTTPRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSData *responseData = [request responseData];
//    NSLog(@"%@", responseData);
//    UIImage *image = [UIImage imageWithData:responseData];
    
//    NSLog(@"%@", image);
//    [photoNewsShowView addImageToimageView:image];
    NSDictionary *jsonDictionaries = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
    
//    NSLog(@"%@", responseData);
     NSLog(@"%@", jsonDictionaries);
//    UIImage *image = [UIImage imageWithData: [jsonDictionaries objectForKey:@"title"]];
//    NSLog(@"%@", image);
//    NSArray *photoNewsData = [jsonDictionary objectForKey:@"data"];
//    NSLog(@"%@", photoNewsData);
//    NSLog(@"%i", [photoNewsData count]);
    
}

- (void)requestFailed :(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@", error);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
