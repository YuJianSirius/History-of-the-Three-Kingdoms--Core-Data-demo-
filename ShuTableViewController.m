//
//  ShuTableViewController.m
//  SanGuoZhi
//
//  Created by xiaojia on 14-3-19.
//  Copyright (c) 2014年 sirius. All rights reserved.
//

#import "ShuTableViewController.h"

@interface ShuTableViewController ()
@property  (strong, nonatomic) NSMutableArray *dataSource;
@end

@implementation ShuTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)initData
{
    if([self.dataSource count]>0){
        return;
    }
    
    NSLog(@"DATASHOUREC COUNT%D",[self.dataSource count]);
    
    NSArray *herosPlist = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shuhan" ofType:@"plist"]];
    
    NSMutableArray *zhugong = [[NSMutableArray alloc] init];
    NSMutableArray *wujiang = [[NSMutableArray alloc] init];
    NSMutableArray *herodata = [[NSMutableArray alloc] init];
    
    for(NSDictionary *eachhero in herosPlist){
        
        Hero *hero = [[Hero alloc] init];
        
        hero.name = [eachhero objectForKey:@"name"];
        hero.secondname = [eachhero objectForKey:@"second name"];
        hero.number = [eachhero objectForKey:@"number"];
        hero.role = [eachhero objectForKey:@"role"];
        hero.story = [eachhero objectForKey:@"story"];
        
        if([hero.role isEqualToString:@"武将"]){
            [wujiang addObject:hero];
        }else if([hero.role isEqualToString:@"主公"]){
            [zhugong addObject:hero];
        }
        
        [herodata addObject:hero];
    }
    
    NSMutableArray *heros = [NSMutableArray arrayWithObjects:zhugong,wujiang,nil];
    self.dataSource = [[NSMutableArray alloc] initWithArray:heros];
    
    _dbmanger = [[DBManger alloc] init];
    
    _dbmanger.initcontents = herodata;
    _dbmanger.kingdomname = @"蜀国";
    //NSLog(@"initcontents%@",dbmanger.initcontents);
    //[_dbmanger insertData];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
            return @"主公";
            break;
        case 1:
            return @"武将";
        default:
            return @"error";
            break;
    }
}

@end
