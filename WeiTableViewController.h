//
//  WeiTableViewController.h
//  SanGuoZhi
//
//  Created by xiaojia on 14-3-19.
//  Copyright (c) 2014年 sirius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManger.h"
#import "DetailViewController.h"

@interface WeiTableViewController : UITableViewController<NSFetchedResultsControllerDelegate,DetailedViewControllerDelegate>
{
    DBManger *_dbmanger;
    NSIndexPath *_selectedIndexPath;
}

@property (nonatomic) UIBarButtonItem *deleteItem;
@property (nonatomic) UIBarButtonItem *insertItem;
@property (nonatomic) UIBarButtonItem *doneItem;

@end
