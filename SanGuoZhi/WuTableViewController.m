//
//  WuTableViewController.m
//  SanGuoZhi
//
//  Created by xiaojia on 5/23/14.
//  Copyright (c) 2014 sirius. All rights reserved.
//

#import "WuTableViewController.h"

@interface WuTableViewController ()

@end

@implementation WuTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initData
{
    
    NSArray *herosPlist = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dongwu" ofType:@"plist"]];
}

@end
