//
//  AppDelegate.m
//  Table
//
//  Created by Yohei Yamaguchi on 2013/06/30.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "AppDelegate.h"

#define NUM_SECTIONS 3
#define NUM_ROWS     20

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // sections
    self.sections = [NSMutableArray new];
    for (int i = 0; i < NUM_SECTIONS; ++i) {
        NSMutableArray *section = [NSMutableArray array];
        for (int i = 0; i < NUM_ROWS; ++i) {
            [section addObject:[NSNumber numberWithBool:NO]];
        }
        [self.sections addObject:section];
    }

    // table
    self.controller = [UITableViewController new];
    self.controller.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStylePlain];
    self.controller.tableView.delegate = self;
    self.controller.tableView.dataSource = self;
    [self.window addSubview:self.controller.view];
    
    // button
    UIButton *editButton = [self createEditButton];
    [self.window addSubview:editButton];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 
- (UIButton*)createEditButton
{
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [editButton setTitle:@"Edit" forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(didClickedEditButton:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect frame = self.controller.tableView.frame;
    frame.size.height = 44;
    editButton.frame = CGRectInset(frame, 4, 4);
    frame.origin.y += frame.size.height;
    frame.size.height = self.controller.tableView.frame.size.height - frame.size.height;
    self.controller.tableView.frame = frame;
    
    return editButton;
}
- (void)didClickedEditButton:(UIButton*)button
{
    [self.controller.tableView setEditing:!self.controller.tableView.editing animated:YES];
    [button setTitle:self.controller.tableView.editing ? @"Done":@"Edit" forState:UIControlStateNormal];
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
