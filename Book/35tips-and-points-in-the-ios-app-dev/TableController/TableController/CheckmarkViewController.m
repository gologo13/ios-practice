//
//  CheckmarkViewController.m
//  TableController
//
//  Created by Yohei Yamaguchi on 2013/06/30.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "CheckmarkViewController.h"

@interface CheckmarkViewController ()

@end

#define NUM_SECTIONS 3
#define NUM_ROWS     20

@implementation CheckmarkViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // sections
        self.sections = [NSMutableArray new];
        for (int i = 0; i < NUM_SECTIONS; ++i) {
            NSMutableArray *section = [NSMutableArray array];
            for (int i = 0; i < NUM_ROWS; ++i) {
                [section addObject:[NSNumber numberWithBool:NO]];
            }
            [self.sections addObject:section];
        }
    }
    return self;
}

#pragma mark - UITableViewDataSource delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.sections objectAtIndex:section] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"項目%d-%d", indexPath.section, indexPath.row];
    NSNumber *selected = self.sections[indexPath.section][indexPath.row];
    cell.accessoryType = ([selected boolValue]) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.sections[indexPath.section] removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected: section:%d row:%d", indexPath.section, indexPath.row);
    
    /*
     if (indexPath.row == (count[indexPath.section] - 1)) {
     ++count[indexPath.section];
     NSArray *indexPaths = @[[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section]];
     [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
     }
     */
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = (cell.accessoryType == UITableViewCellAccessoryNone) ?
    UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    NSNumber *selected = [NSNumber numberWithBool:(cell.accessoryType == UITableViewCellAccessoryCheckmark)];
    self.sections[indexPath.section][indexPath.row] = selected;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"section %d", section];
}
@end
