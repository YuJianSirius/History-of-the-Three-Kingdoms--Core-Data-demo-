//
//  WeiTableViewController.m
//  SanGuoZhi
//
//  Created by xiaojia on 14-3-19.
//  Copyright (c) 2014年 sirius. All rights reserved.
//

#import "WeiTableViewController.h"
#import "Hero.h"
#import "StoryViewController.h"
#import "DetailViewController.h"


@interface WeiTableViewController ()
@property  (strong, nonatomic) NSMutableArray *dataSource;
@property  (strong, nonatomic) NSFetchedResultsController *fetchresults;

@end



@implementation WeiTableViewController

@synthesize fetchresults = _fetchresults;
@synthesize deleteItem = _deleteItem, insertItem = _insertItem, doneItem = _doneItem;

#pragma mark - getter
-(NSFetchedResultsController *)fetchresults
{
    if(!_fetchresults){
        _fetchresults = [[NSFetchedResultsController alloc] init];
        _fetchresults = [_dbmanger fetchHeros];
        _fetchresults.delegate = self;
    }
    return _fetchresults;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self initData];
    [self initUI];
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if(_dbmanger){
        Kingdom *kingdom = [_dbmanger fetchKingdom];
        if(kingdom){
            self.navigationItem.title = kingdom.name;
        }
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"numberofsection%d",self.fetchresults.sections.count);
    return self.fetchresults.sections.count;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /*
    NSArray *group = [self.dataSource objectAtIndex:section];
    return [group count];*/
    id<NSFetchedResultsSectionInfo> sectionInfo = nil;
    
    sectionInfo = [[self.fetchresults sections] objectAtIndex:section];
    
    NSLog(@"number of objects %d",[sectionInfo numberOfObjects]);
    
    return [sectionInfo numberOfObjects];
}

#pragma mark - Table View delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Hero";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //NSArray *group = [self.dataSource objectAtIndex:indexPath.section];
    XHero *hero = (XHero *)[self.fetchresults objectAtIndexPath:indexPath];
    
    if(hero){
        
        cell.textLabel.text = hero.name;
        cell.detailTextLabel.text = hero.secondname;
        
        if(hero.image){
           cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",hero.number]];
        }else{
           cell.imageView.image = [UIImage imageNamed:@"empty"];
        }
        
        
    }
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.navigationItem.rightBarButtonItem == nil){
        return UITableViewCellEditingStyleInsert;
    }else if(self.navigationItem.leftBarButtonItem == nil){
        return UITableViewCellEditingStyleDelete;
    }else{
        return UITableViewCellEditingStyleNone;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
/*
-(BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}*/

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [_dbmanger deleteHeros:indexPath withFetchedResults:self.fetchresults];
        
        NSLog(@"detele");
        /*
        NSMutableArray *group = [self.dataSource objectAtIndex:indexPath.section];
        
        Hero *delelehero = [group objectAtIndex:indexPath.row];
        
        [group removeObject:delelehero];
        
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        */
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        NSLog(@"INSERT");
        
        id<NSFetchedResultsSectionInfo> sectionInfo = nil;
        Hero *newhero = [[Hero alloc] init];
        
        newhero.name = @"newhero";
        newhero.secondname = @"字";
        
        sectionInfo = [self.fetchresults.sections objectAtIndex:indexPath.section];
        newhero.role = [sectionInfo name];
        
        if(self.fetchresults && self.fetchresults.fetchedObjects){
            newhero.number = [NSNumber numberWithInt:self.fetchresults.fetchedObjects.count + 5];
            NSLog(@"%@",newhero.number);
        }else{
            newhero.number = @1;
        }
        
        [_dbmanger insertHeros:newhero withFetchedResults:self.fetchresults];
    }   
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue");
    if([sender isKindOfClass:[UITableViewCell class]]){
        NSIndexPath *indexpath = [self.tableView indexPathForCell:sender];
        if(indexpath){
            if([segue.identifier isEqualToString:@"Show Story"]){
                if([segue.destinationViewController isKindOfClass:[StoryViewController class]]){
                    
                    XHero *hero = [self.fetchresults objectAtIndexPath:indexpath];
                    StoryViewController *storyVC = (StoryViewController *)segue.destinationViewController;
                    storyVC.Story = hero.story;
                    storyVC.heroname = hero.name;
                    //storyVC.title = hero.name;
                    
                    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
                    returnButtonItem.title = hero.name;
                    self.navigationItem.backBarButtonItem = returnButtonItem;
                    /*
                    _selectedIndexPath = indexpath;
                    XHero *hero = [self.fetchresults objectAtIndexPath:indexpath];
                    DetailViewController *DetailVC = (DetailViewController *)segue.destinationViewController;
                    
                    DetailVC.delegate = self;
                    DetailVC.heroInfo = hero;*/
                }
            }
        }
    }
    
}

 

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
            return @"主公";
            break;
        case 1:
            return @"谋士";
        default:
            return @"error";
            break;
    }
}

#pragma mark - init
-(void)initData
{
    if([self.dataSource count]>0){
        return;
    }
    NSLog(@"DATASHOUREC COUNT%D",[self.dataSource count]);

    NSArray *herosPlist = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"caowei" ofType:@"plist"]];

    NSMutableArray *zhugong = [[NSMutableArray alloc] init];
    NSMutableArray *moushi = [[NSMutableArray alloc] init];
    NSMutableArray *herodata = [[NSMutableArray alloc] init];
    
    for(NSDictionary *eachhero in herosPlist){
        Hero *hero = [[Hero alloc] init];
        
        hero.name = [eachhero objectForKey:@"name"];
        hero.secondname = [eachhero objectForKey:@"second name"];
        hero.number = [eachhero objectForKey:@"number"];
        hero.role = [eachhero objectForKey:@"role"];
        hero.story = [eachhero objectForKey:@"story"];
       
        if([hero.role isEqualToString:@"谋士"]){
            [moushi addObject:hero];
        }else if([hero.role isEqualToString:@"主公"]){
            [zhugong addObject:hero];
        }
        
        [herodata addObject:hero];
    }

    NSMutableArray *heros = [NSMutableArray arrayWithObjects:zhugong,moushi,nil];
    self.dataSource = [[NSMutableArray alloc] initWithArray:heros];
    
    _dbmanger = [[DBManger alloc] init];
    
    _dbmanger.initcontents = herodata;
    _dbmanger.kingdomname = @"魏国";
    //NSLog(@"initcontents%@",dbmanger.initcontents);
    //[_dbmanger insertData];
}

-(void)initUI
{
    _deleteItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(actBeginDelete:)];
    
    _insertItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actBeginInsert:)];
    
    _doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(actEndEdit:)];
    
    self.navigationItem.rightBarButtonItem = _deleteItem;
    //self.navigationItem.leftBarButtonItem  = _insertItem;   屏蔽了插入功能
    
  
}

#pragma makr - action
-(IBAction)actBeginDelete:(id)sender
{
    
    self.navigationItem.rightBarButtonItem = _doneItem;
    self.navigationItem.leftBarButtonItem  = nil;
    [self.tableView setEditing:YES animated:YES];
}

-(IBAction)actBeginInsert:(id)sender
{
    
    self.navigationItem.leftBarButtonItem   = _doneItem;
    self.navigationItem.rightBarButtonItem  = nil;
    [self.tableView setEditing:YES animated:YES];
}

-(IBAction)actEndEdit:(id)sender
{
    
    self.navigationItem.rightBarButtonItem = _deleteItem;
    //self.navigationItem.leftBarButtonItem  = _insertItem;     屏蔽了插入功能
    [self.tableView setEditing:NO animated:YES];
}

#pragma mark - NSFetchedResultsController delegate

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}


-(void)controller:(NSFetchedResultsController *)controller
  didChangeObject:(id)anObject
      atIndexPath:(NSIndexPath *)indexPath
    forChangeType:(NSFetchedResultsChangeType)type
     newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    NSIndexPath *PreIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    NSIndexPath *aNewIndexPath = [NSIndexPath indexPathForRow:newIndexPath.row inSection:newIndexPath.section];
    id<NSFetchedResultsSectionInfo> sectionInfo = nil;
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            sectionInfo = [controller.sections objectAtIndex:newIndexPath.section];
            PreIndexPath = [NSIndexPath indexPathForRow:[sectionInfo numberOfObjects] -1
                                              inSection:newIndexPath.section];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:PreIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:PreIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            NSLog(@"change");/*
            [self configureCell:[tableView cellForRowAtIndexPath:PreIndexPath] atIndexPath:indexPath];*/
            break;
    
    }
}

-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}
             
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)fetchedIndexPath
{
    if(!cell || !fetchedIndexPath){
        return;
    }
    
    XHero *newhero = (XHero*)[self.fetchresults objectAtIndexPath:fetchedIndexPath];
    
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",newhero.number]];
    if(!image){
        image = [UIImage imageNamed:@"empty"];
    }
    
    cell.textLabel.text = newhero.name;
    cell.detailTextLabel.text = newhero.secondname;
    cell.imageView.image = image;
    
}

#pragma mark - DetailedViewController delegate
- (void)saveDetailedInfo:(DetailViewController*)detailedInfoVC
{
    //收起
    [self removeFromParentViewController];
     NSLog(@"save");
    
    if (!_selectedIndexPath) {
        return;
    }
    //交给DBManager来更新持久层
    //界面的更新则等待NSFetchedResultController的代理回调函数实现
    [_dbmanger updataHeros:_selectedIndexPath
        withFetchedResults:self.fetchresults
                  newnName:detailedInfoVC.nameTextField.text];
    
   
}

- (void)cancelDetailedInfo:(DetailViewController*)detailedInfoVC
{
    //[self presentViewController: animated:YES completion:NULL];
}

@end
