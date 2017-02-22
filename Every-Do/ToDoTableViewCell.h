//
//  ToDoTableViewCell.h
//  Every-Do
//
//  Created by Dave Augerinos on 2017-02-21.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDo.h"

@interface ToDoTableViewCell : UITableViewCell

@property (strong, nonatomic) UISwipeGestureRecognizer *swipeGesture;

- (void)configureToDoCell:(ToDo *) toDo;

@end
