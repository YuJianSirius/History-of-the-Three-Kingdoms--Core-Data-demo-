//
//  DBManger.m
//  SanGuoZhi
//
//  Created by xiaojia on 14-3-22.
//  Copyright (c) 2014年 sirius. All rights reserved.
//

#import "DBManger.h"
#import "Hero.h"
#import "XHero.h"

@implementation DBManger

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize fetchedResultsController = _fetchedResultsController;

@synthesize initcontents;

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

-(void) insertData
{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    /*
    NSManagedObject *heroInfo = [NSEntityDescription insertNewObjectForEntityForName:@"XHero" inManagedObjectContext:content];*/
    
    NSEntityDescription *kingdomEntity = [NSEntityDescription entityForName:@"Kingdom"
                                                     inManagedObjectContext:context];
    
    Kingdom *kingdom = [NSEntityDescription insertNewObjectForEntityForName:[kingdomEntity name]
                                                     inManagedObjectContext:context];
    
    kingdom.name = self.kingdomname;
    
    NSEntityDescription	*XHeroEntity = [NSEntityDescription entityForName:@"XHero"
                                                  inManagedObjectContext:context];
    
    for(Hero *eachhero in self.initcontents){
        
        XHero *hero = [NSEntityDescription insertNewObjectForEntityForName:[XHeroEntity name]
                                                    inManagedObjectContext:context];
        // NSLog(@"!!!!!!!!!!!!! %@",eachhero.name);
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",eachhero.number]];
        if(!image){
           image = [UIImage imageNamed:@"empty"];
        }
        
        hero.secondname = eachhero.secondname;
        hero.number = eachhero.number;
        hero.name = eachhero.name;
        hero.role = eachhero.role;
        hero.story = eachhero.story;
        hero.image = image;
        
        if([eachhero.number isEqualToNumber:@0]){
            kingdom.master = hero;
        }
        
        [kingdom addHerosObject:hero];
        
        NSError *error;
         if(![context save:&error]){
            NSLog(@"can't save:%@",[error localizedDescription]);
        }
    }
}

#pragma mark - fetch data

-(Kingdom *)fetchKingdom{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest   *fetchRequest   = [[NSFetchRequest alloc] init];
    NSSortDescriptor *sortDescriptor = nil;
    NSArray          *arrKingdomList = nil;
    NSError          *error          = nil;
    
    if(context == nil){
        return nil;
    }
    
    NSEntityDescription *kingdomEntity = [NSEntityDescription entityForName:@"Kingdom" inManagedObjectContext:context];
    
    [fetchRequest setEntity:kingdomEntity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",self.kingdomname];

    [fetchRequest setPredicate:predicate];
    
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor,nil]];
    
    arrKingdomList = [context executeFetchRequest:fetchRequest error:&error];
    
    if(arrKingdomList && arrKingdomList.count >0){
        return (Kingdom *)[arrKingdomList objectAtIndex:0];
    }
    
    return nil;
}

-(NSFetchedResultsController *)fetchHeros
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *heroEntity = [NSEntityDescription entityForName:@"XHero" inManagedObjectContext:context];
    NSFetchRequest *fetchquest = [[NSFetchRequest alloc] init];
    NSError *error;
    
    if(!context){
        return nil;
    }
    
    [fetchquest setEntity:heroEntity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"heroInfo.name = %@",self.kingdomname];
    [fetchquest setPredicate:predicate];
    
    NSSortDescriptor *roleDescriptor = [[NSSortDescriptor alloc] initWithKey:@"role" ascending:YES];
    NSSortDescriptor *numberDescriptor = [[NSSortDescriptor alloc] initWithKey:@"number" ascending:YES];
    [fetchquest setSortDescriptors:[NSArray arrayWithObjects:roleDescriptor,numberDescriptor,nil]];
    
    if(!_fetchedResultsController){
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchquest managedObjectContext:context sectionNameKeyPath:@"role" cacheName:@"heros"];
    }else{
        [NSFetchedResultsController deleteCacheWithName:@"heros"];
    }
    
    if([_fetchedResultsController performFetch:&error] && !error){
        return _fetchedResultsController;
    }else{
        return nil;
    }
}

#pragma mark - delete . insert . update
-(void)deleteHeros:(NSIndexPath *)IndexPath
withFetchedResults:(NSFetchedResultsController *)FetchedResults
{
    if(!IndexPath || !FetchedResults){
        return;
    }
    
    NSManagedObjectContext *context = FetchedResults.managedObjectContext;
    
    [context deleteObject:[FetchedResults objectAtIndexPath:IndexPath]];
    
    NSError *error;
    
    if(![context save:&error]){
        NSLog(@"error %@ , %@", error, [error userInfo]);
        abort();
    }
}

-(void)insertHeros:(Hero *)newhero
withFetchedResults:(NSFetchedResultsController *)FetchedResults
{
    if(!newhero || !FetchedResults){
        return;
    }
    
    NSManagedObjectContext *context = FetchedResults.managedObjectContext;
    
    NSEntityDescription *xHeroEntity = [NSEntityDescription entityForName:@"XHero" inManagedObjectContext:context];
    
    Kingdom *kingdom = [self fetchKingdom];
    
    XHero *hero = [NSEntityDescription insertNewObjectForEntityForName:[xHeroEntity name]
                                                inManagedObjectContext:context];
    
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",newhero.number]];
    if(!image){
        image = [UIImage imageNamed:@"etmpy"];
    }
    
    hero.name = newhero.name;
    hero.secondname = newhero.secondname;
    hero.number = newhero.number;
    hero.role = newhero.role;
    hero.image = image;
    
    [kingdom addHerosObject:hero];
    
    NSError *error;
    
    if(![context save:&error]){
        NSLog(@"save error %@, %@", error, [error userInfo]);
        abort();
    }
}

-(void)updataHeros:(NSIndexPath *)IndexPath
withFetchedResults:(NSFetchedResultsController *)FetchedResults
          newnName:(NSString *)Heroname
{
    NSManagedObjectContext *context = FetchedResults.managedObjectContext;
    
    if(!IndexPath || !FetchedResults){
        return;
    }
    
    XHero *hero = [FetchedResults objectAtIndexPath:IndexPath];
    hero.name   =  Heroname;
    
    NSError *error;
    
    if(![context save:&error]){
        NSLog(@"save error %@, %@", error, [error userInfo]);
        abort();
    }
}


#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    id hasInit = [[NSUserDefaults standardUserDefaults] objectForKey:@"initFinished"];
    if (!hasInit ||
        ([hasInit isKindOfClass:[NSNumber class]] && ![(NSNumber*)hasInit boolValue]))
    {
        NSLog(@"hasInit");
        [self insertData];
        [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"initFinished"];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MyModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"SanGuoZhi.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}




@end
