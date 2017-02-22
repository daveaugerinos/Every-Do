//
//  ToDoTableViewCell.m
//  Every-Do
//
//  Created by Dave Augerinos on 2017-02-21.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import "ToDoTableViewCell.h"

@interface ToDoTableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descripLabel;
@property (strong, nonatomic) IBOutlet UILabel *priorityNumLabel;
@property (strong, nonatomic) ToDo *myToDo;

@end

@implementation ToDoTableViewCell

- (void)configureToDoCell:(ToDo *) toDo {
    
    self.myToDo = toDo;
    
    // Set labels with object property values
    self.titleLabel.text = toDo.myTitle;
    self.descripLabel.text = toDo.myDescrip;
    self.priorityNumLabel.text = [NSString stringWithFormat:@"%i", toDo.myPriorityNum];
    
    if(toDo.isCompleted) {
        [self toggleToDoDescrip];
    }
}

- (void)toggleToDoDescrip {
    
    if(self.myToDo.isCompleted) {

        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self.myToDo.myTitle];
        
        [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                value:@2
                                range:NSMakeRange(0, [attributeString length])];
        
        self.titleLabel.attributedText = [attributeString mutableCopy];
    }
    
    self.myToDo.isCompleted = !self.myToDo.isCompleted;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
