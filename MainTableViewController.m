//
//  MainTableViewController.m
//  SanGuoZhi
//
//  Created by xiaojia on 14-3-19.
//  Copyright (c) 2014年 sirius. All rights reserved.
//

#import "MainTableViewController.h"
#import "WeiTableViewController.h"
#import "DBManger.h"

@interface MainTableViewController ()
@property (nonatomic, strong) NSArray *KingdomList;

@end

@implementation MainTableViewController

@synthesize KingdomList = _KingdomList;

- (void)viewDidLoad
{
    /*
     self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:70.0f/255.0f
     green:100.0f/255.0f
     blue:120.0f/255.0f
     alpha:1.0f];
     */
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:70.0f/255.0f
                                                                             green:130.0f/255.0f
                                                                              blue:180.0f/255.0f
                                                                             alpha:1.0f]];
    //暂时没发现作用
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //[self setNeedsStatusBarAppearanceUpdate];
    
    UIImage *image = [UIImage imageNamed:@"b_header_bg"];
    UIImage *bgNav = [image stretchableImageWithLeftCapWidth:1 topCapHeight:5];
    
    [self.navigationController.navigationBar setBackgroundImage:bgNav forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setTitle:@"三国志"];
    
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];


    
    self.tableView.bounces = NO;
    
    self.KingdomList = [NSArray arrayWithObjects:@"weiguo",@"shuguo",@"wuguo",nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self KingdomList] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [self.KingdomList objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self.KingdomList objectAtIndex:indexPath.row]]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSIndexPath *indexpath = [self.tableView indexPathForCell:sender];
    NSLog(@"%i 5yue8ri test",indexpath.row );
    if (indexpath.row == 0) {
        
        
    }else if(indexpath.row == 1){
        
    }
    
}


@end
