//
//  StoryViewController.m
//  SanGuoZhi
//
//  Created by xiaojia on 14-3-21.
//  Copyright (c) 2014年 sirius. All rights reserved.
//

#import "StoryViewController.h"

@interface StoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *StoryTextView;

@end

@implementation StoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.StoryTextView.delegate = self;
    self.StoryTextView.text = self.story;
    self.StoryTextView.font = [UIFont systemFontOfSize:20.0f];
    
}


@end
