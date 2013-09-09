//
//  DetailViewController.m
//  CoreDataSample
//
//  Created by Yohei Yamaguchi on 2013/09/08.
//  Copyright (c) 2013年 Yohei Yamaguchi. All rights reserved.
//

#import "DetailViewController.h"
#import "Address.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize detailItem;

#pragma mark - Managing the detail item

- (Person*)detailItem
{
    if (!detailItem) {
        detailItem = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Person class])
                                                        inManagedObjectContext:self.managedObjectContext];
        detailItem.address = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Address class])
                                                                inManagedObjectContext:self.managedObjectContext];
    }
    return detailItem;
}

- (void)setDetailItem:(id)newDetailItem
{
    if (detailItem != newDetailItem) {
        detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    [self becomeFirstResponder];

    if (self.detailItem) {
        self.nameField.text = self.detailItem.name;
        self.zipCodeField.text = self.detailItem.address.zipCode;
        self.stateField.text = self.detailItem.address.state;
        self.cityField.text = self.detailItem.address.city;
        self.streetField.text = self.detailItem.address.other;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender
{
    self.detailItem.name = self.nameField.text;
    self.detailItem.address.zipCode = self.zipCodeField.text;
    self.detailItem.address.state = self.stateField.text;
    self.detailItem.address.city = self.cityField.text;
    self.detailItem.address.other = self.streetField.text;
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error: %@, %@", error, [error userInfo]);
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    [self.view endEditing:YES];
}

@end
