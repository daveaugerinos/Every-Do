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
#import "AddItemViewController.h"

@interface MasterViewController () <UITableViewDataSource, UITableViewDelegate, AddToDoDelegate>

@property NSMutableArray *objects;
@property (strong, nonatomic) UISwipeGestureRecognizer *swipeRightGesture;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    // Added for testing
    if (!self.objects) {
        
        self.objects = [[NSMutableArray alloc] init];
    }
    
    
    // Initial to dos for testing
    ToDo *myToDo1 = [[ToDo alloc] initWithTitle:@"Buy Groceries"
                                 andDescription:@"Kale, coconuts, walnuts, dark chocolate almonds"
                                    andPriority:3
                                 andIsCompleted:YES];
    
    ToDo *myToDo2 = [[ToDo alloc] initWithTitle:@"Birthday Party"
                                 andDescription:@"Meet friends in Gastown on Thursday at 7 PM for celebration"
                                    andPriority:2
                                 andIsCompleted:YES];

    ToDo *myToDo3 = [[ToDo alloc] initWithTitle:@"Finish Coding Assignment"
                                 andDescription:@"Finish this afternoons Objective-C assignment"
                                    andPriority:1
                                 andIsCompleted:NO];
    
    ToDo *myToDo4 = [[ToDo alloc] initWithTitle:@"Attend Lunch on Wed"
                                 andDescription:@"Meet so and so at such and such at this time"
                                    andPriority:1
                                 andIsCompleted:NO];
    
    ToDo *myToDo5 = [[ToDo alloc] initWithTitle:@"Another to do!"
                                 andDescription:@"Get this done!"
                                    andPriority:5
                                 andIsCompleted:YES];
    
    [self.objects insertObject:myToDo1 atIndex:0];
    [self.objects insertObject:myToDo2 atIndex:0];
    [self.objects insertObject:myToDo3 atIndex:0];
    [self.objects insertObject:myToDo4 atIndex:0];
    [self.objects insertObject:myToDo5 atIndex:0];
    
    // Sort objects array into non completed and completed to dos
    [self sortObjectsArrayWithKey:@"isCompleted" ascending:YES];
    
    [self.tableView reloadData];
    
    self.swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight:)];
    self.swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.tableView addGestureRecognizer:self.swipeRightGesture];
}


- (void)viewWillAppear:(BOOL)animated {
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didSwipeRight:(UISwipeGestureRecognizer *)sender {
 
    if(sender.direction == UISwipeGestureRecognizerDirectionRight) {
        
        CGPoint locationInTableView = [sender locationInView:self.tableView];
        
        NSIndexPath *myIndexPath = [self.tableView indexPathForRowAtPoint:locationInTableView];
        
        ToDoTableViewCell *myCell = [self.tableView cellForRowAtIndexPath:myIndexPath];
        
        [myCell toggleToDoDescrip];
    }
}


#pragma mark - Add and Insert -

- (void)addItem:(id)sender {
    
    [self performSegueWithIdentifier:@"addItem" sender:sender];
}

- (void)addToDo:(ToDo *)toDo {
    
    [self insertNewObject:toDo];
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

- (void)sortObjectsArrayWithKey:(NSString *)key ascending:(BOOL)boolean {
    
    // Sort objects array by key and ascending or descending order
    NSSortDescriptor *isCompletedDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:boolean];
    NSArray *sortDescriptors = @[isCompletedDescriptor];
    [self.objects sortUsingDescriptors:sortDescriptors];
}

#pragma mark - Segues -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ToDo *myToDo = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[segue destinationViewController];
        [controller setDetailItem:myToDo];
    }
    
    if ([[segue identifier] isEqualToString:@"addItem"]) {
    
        AddItemViewController *controller = (AddItemViewController *)[segue destinationViewController];
        controller.delegate = self;
    }
}


#pragma mark - Table View -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.objects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ToDoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoTableViewCell" forIndexPath:indexPath];
        
    [cell configureToDoCell:self.objects[indexPath.row]];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @"List of To Do Items";
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
