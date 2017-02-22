//
//  ToDo.h
//  Every-Do
//
//  Created by Dave Augerinos on 2017-02-21.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDo : NSObject

@property (strong, nonatomic) NSString *myTitle;
@property (strong, nonatomic) NSString *myDescrip;
@property (assign, nonatomic) int myPriorityNum;
@property (assign, nonatomic) BOOL isCompleted;

- (instancetype)initWithTitle:(NSString *)title andDescription:(NSString *)descrip andPriority:(int)priorityNum andIsCompleted:(BOOL)isCompleted;

@end
