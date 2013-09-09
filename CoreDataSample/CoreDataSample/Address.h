//
//  Address.h
//  DataSample
//
//  Created by Yohei Yamaguchi on 2013/09/08.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Address : NSManagedObject
@property (nonatomic, strong) NSString *zipCode;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *other;
@end
