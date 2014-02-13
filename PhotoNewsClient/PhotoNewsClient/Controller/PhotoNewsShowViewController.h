//
//  PhotoNewsShowViewController.h
//  PhotoNewsClient
//
//  Created by xyooyy on 14-2-11.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoNewsShowView.h"
#import "ASIHTTPRequest.h"

@interface PhotoNewsShowViewController : UIViewController<ASIHTTPRequestDelegate> {
    PhotoNewsShowView *photoNewsShowView;
}
@end
