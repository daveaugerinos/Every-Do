//
//  AddItemViewController.h
//  Every-Do
//
//  Created by Dave Augerinos on 2017-02-22.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDo.h"

@protocol AddToDoDelegate <NSObject>

-(void)addToDo:(ToDo *)toDo;

@end

@interface AddItemViewController : UIViewController 

@property (weak, nonatomic) id <AddToDoDelegate> delegate;

@end
