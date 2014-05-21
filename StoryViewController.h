//
//  StoryViewController.h
//  SanGuoZhi
//
//  Created by xiaojia on 14-3-21.
//  Copyright (c) 2014年 sirius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryViewController : UIViewController<UITextViewDelegate>


@property (strong, nonatomic) NSString *story;
@property (strong, nonatomic) NSString *heroname;


@end
