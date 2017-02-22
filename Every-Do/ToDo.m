//
//  ToDo.m
//  Every-Do
//
//  Created by Dave Augerinos on 2017-02-21.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import "ToDo.h"

@implementation ToDo

-(instancetype)initWithTitle:(NSString *)title andDescription:(NSString *)descrip andPriority:(int)priorityNum andIsCompleted:(BOOL)isCompleted {
    
    self = [super init];
    if (self) {
        self.myTitle = title;
        self.myDescrip = descrip;
        self.myPriorityNum = priorityNum;
        self.isCompleted = isCompleted;
    }
    return self;
}

@end
