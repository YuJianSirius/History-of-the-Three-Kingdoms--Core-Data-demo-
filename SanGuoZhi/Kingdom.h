//
//  Kingdom.h
//  SanGuoZhi
//
//  Created by xiaojia on 14-3-24.
//  Copyright (c) 2014年 sirius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class XHero;

@interface Kingdom : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSSet *heros;
@property (nonatomic, retain) XHero *master;
@end

@interface Kingdom (CoreDataGeneratedAccessors)

- (void)addHerosObject:(XHero *)value;
- (void)removeHerosObject:(XHero *)value;
- (void)addHeros:(NSSet *)values;
- (void)removeHeros:(NSSet *)values;

@end
