//
//  Person.h
//  DataSample
//
//  Created by Yohei Yamaguchi on 2013/09/08.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Address;

@interface Person : NSManagedObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) Address *address;
@end
