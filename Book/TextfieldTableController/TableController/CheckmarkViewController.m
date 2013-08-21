//
//  CheckmarkViewController.m
//  TableController
//
//  Created by Yohei Yamaguchi on 2013/06/30.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "CheckmarkViewController.h"
#import "InputViewController.h"

@interface CheckmarkViewController ()

@end

#define NUM_SECTIONS 3
#define NUM_ROWS     2

@implementation CheckmarkViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // sections
        self.sections = [NSMutableArray new];
        for (int i = 0; i < NUM_SECTIONS; ++i) {
            NSMutableArray *section = [NSMutableArray array];
            for (int j = 0; j < NUM_ROWS; ++j) {
                //[section addObject:[NSNumber numberWithBool:NO]];
                NSString *title = [NSString stringWithFormat:@"項目%d-%d", i, j];
                NSString *memo  = [NSString stringWithFormat:@"メモ%d-%d", i, j];
                [section addObject:@{@"title":title, @"memo":memo}];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = self.sections[indexPath.section][indexPath.row][@"title"];
    cell.detailTextLabel.text = self.sections[indexPath.section][indexPath.row][@"memo"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
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

    self.editIndex = indexPath;
    
    InputViewController *inputViewController = [[InputViewController alloc] initWithStyle:UITableViewStyleGrouped];
    inputViewController.data = [NSMutableDictionary dictionaryWithDictionary:self.sections[indexPath.section][indexPath.row]];
    inputViewController.inputDelegate = self;
    [self.navigationController pushViewController:inputViewController animated:YES];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"section %d", section];
}

#pragma mark - input view controller delegate

- (void)inputViewEnter:(InputViewController *)InputViewController title:(NSString *)text
{
    NSMutableDictionary *dic = self.sections[self.editIndex.section][self.editIndex.row];
    dic[@"title"] = text;
    [self.tableView reloadRowsAtIndexPaths:@[self.editIndex] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)inputViewEnter:(InputViewController *)InputViewController memo:(NSString *)text
{
    NSMutableDictionary *dic = self.sections[self.editIndex.section][self.editIndex.row];
    dic[@"memo"] = text;
    [self.tableView reloadRowsAtIndexPaths:@[self.editIndex] withRowAnimation:UITableViewRowAnimationNone];
}


@end
