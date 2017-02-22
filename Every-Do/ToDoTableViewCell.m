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

@end

@implementation ToDoTableViewCell

- (void)configureToDoCell:(ToDo *) toDo {
    
    // Set labels with object property values
    self.titleLabel.text = toDo.myTitle;
    self.descripLabel.text = toDo.myDescrip;
    self.priorityNumLabel.text = [NSString stringWithFormat:@"%i", toDo.myPriorityNum];
    
    if(toDo.isCompleted) {
        [self toggleToDoDescrip:toDo];
    }
}

- (void)toggleToDoDescrip:(ToDo *)toDo {
    toDo.isCompleted = !toDo.isCompleted;
    
    if(toDo.isCompleted) {

        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:toDo.myDescrip];
        
        [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                value:@2
                                range:NSMakeRange(0, [attributeString length])];
    }
}

- (void)didSwipe:(UISwipeGestureRecognizer *)sender {
    
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
