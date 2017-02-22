//
//  DetailViewController.m
//  Every-Do
//
//  Created by Dave Augerinos on 2017-02-21.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import "DetailViewController.h"
#import "ToDo.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;
@property (weak, nonatomic) IBOutlet UILabel *descripLabel;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item -

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}


- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        
        if ([self.detailItem isKindOfClass:[ToDo class]]) {
            
            ToDo *myToDo = self.detailItem;
            
            self.titleLabel.text = myToDo.myTitle;
            self.priorityLabel.text = [NSString stringWithFormat:@"Priority: %i",myToDo.myPriorityNum];
            self.descripLabel.text = myToDo.myDescrip;
        }
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
