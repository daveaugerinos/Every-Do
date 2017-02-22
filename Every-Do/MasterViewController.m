//
//  MasterViewController.m
//  Every-Do
//
//  Created by Dave Augerinos on 2017-02-21.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ToDo.h"
#import "ToDoTableViewCell.h"

@interface MasterViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSMutableArray *objects;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    // Initial To Dos
    ToDo *myToDo1 = [[ToDo alloc] initWithTitle:@"Buy Groceries"
                                 andDescription:@"Kale, coconuts, walnuts, dark chocolate almonds"
                                    andPriority:3
                                 andIsCompleted:NO];
    
    ToDo *myToDo2 = [[ToDo alloc] initWithTitle:@"Birthday Party"
                                 andDescription:@"Meet friends in Gastown on Thursday at 7 PM for celebration"
                                    andPriority:2
                                 andIsCompleted:YES];

    ToDo *myToDo3 = [[ToDo alloc] initWithTitle:@"Finish Coding Assignment"
                                 andDescription:@"Finish this afternoons Objective-C assignment"
                                    andPriority:1
                                 andIsCompleted:NO];
    
    [self insertNewObject:myToDo1];
    [self insertNewObject:myToDo2];
    [self insertNewObject:myToDo3];
}


- (void)viewWillAppear:(BOOL)animated {
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)insertNewObject:(id)sender {
    
    if (!self.objects) {
        
        self.objects = [[NSMutableArray alloc] init];
    }
    
    [self.objects insertObject:sender atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Sort Array -

- (NSArray *)sortObjectArray:(NSMutableArray *)array withKey:(NSString *)key ascending:(BOOL)boolean {
    
    NSSortDescriptor *isCompletedDescriptor = [[NSSortDescriptor alloc] initWithKey:key
                                                                          ascending:boolean];
    NSArray *sortDescriptors = @[isCompletedDescriptor];
    NSArray *sortedArray = [array sortedArrayUsingDescriptors:sortDescriptors];

    return sortedArray;
}

#pragma mark - Segues -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[segue destinationViewController];
        [controller setDetailItem:object];
    }
}


#pragma mark - Table View -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    // Sort array into non completed and completed to dos
    NSArray *sortedArray = [self sortObjectArray:self.objects withKey:@"isCompleted" ascending:YES];
    
    // Iterate thru sorted array and return count for section based on number of
    // non completed or completed to do objects
    if(sortedArray) {
        
        int count = 1;
        
        for (ToDo *myToDo in sortedArray) {
            
            if(myToDo.isCompleted) {
                
                count++;
            }
        }
        
        if(section == 0) {
            return count;
        }
        
        else {
            return (int)sortedArray.count - count;
        }
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ToDoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoTableViewCell" forIndexPath:indexPath];
    
    // Sort array into non completed and completed to dos
    NSArray *sortedArray = [self sortObjectArray:self.objects withKey:@"isCompleted" ascending:YES];
    
    // Iterate thru sorted array to find index position for non completed vs completed to dos
    int index = 0;
    
    for (ToDo *myToDo in sortedArray) {
        
        if(myToDo.isCompleted) {
            index++;
        }
    }
    
    // Check section and return cell based on index position
    if(indexPath.section == 0) {
        
         [cell configureToDoCell:sortedArray[indexPath.row]];
    }
    
    else {
        
         [cell configureToDoCell:sortedArray[indexPath.row + index]];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if(section == 0) {
        return @"List of To Do Items";
    }
    else {
        return @"Completed To Do Items";
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


@end
