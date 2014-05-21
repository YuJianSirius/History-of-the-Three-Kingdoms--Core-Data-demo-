//
//  DBManger.h
//  SanGuoZhi
//
//  Created by xiaojia on 14-3-22.
//  Copyright (c) 2014年 sirius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Kingdom.h"
#import "XHero.h"
#import "Hero.h"

@interface DBManger : NSObject


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSFetchedResultsController *fetchedResultsController;


@property (strong, nonatomic) NSArray *initcontents;
@property (strong, nonatomic) NSString *kingdomname;

-(void)insertData;
-(Kingdom *)fetchKingdom;
-(NSFetchedResultsController *)fetchHeros;
-(void)deleteHeros:(NSIndexPath *)IndexPath
withFetchedResults:(NSFetchedResultsController *)FetchedResults;
-(void)insertHeros:(Hero *)newhero
withFetchedResults:(NSFetchedResultsController *)FetchedResults;
-(void)updataHeros:(NSIndexPath *)IndexPath
withFetchedResults:(NSFetchedResultsController *)FetchedResults
          newnName:(NSString *)Heroname;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end
