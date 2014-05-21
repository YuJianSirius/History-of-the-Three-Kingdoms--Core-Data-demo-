//
//  XHero.h
//  SanGuoZhi
//
//  Created by xiaojia on 14-3-27.
//  Copyright (c) 2014年 sirius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Kingdom;

@interface XHero : NSManagedObject

@property (nonatomic, retain) id image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSString * role;
@property (nonatomic, retain) NSString * story;
@property (nonatomic, retain) NSString * secondname;
@property (nonatomic, retain) Kingdom *heroInfo;
@property (nonatomic, retain) Kingdom *masterInfo;

@end
