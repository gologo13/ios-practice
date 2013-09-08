//
//  CheckmarkViewController.h
//  TableController
//
//  Created by Yohei Yamaguchi on 2013/06/30.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputViewController.h"

@interface CheckmarkViewController : UITableViewController<InputViewControllerDelegate>
@property (strong, nonatomic) NSMutableArray *sections;
@property (strong, nonatomic) NSIndexPath *editIndex;
@end
