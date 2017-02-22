//
//  AddItemViewController.m
//  Every-Do
//
//  Created by Dave Augerinos on 2017-02-22.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController ()

@property (weak, nonatomic) IBOutlet UILabel *vcTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;
@property (weak, nonatomic) IBOutlet UILabel *descripLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *priorityTextField;
@property (weak, nonatomic) IBOutlet UITextView *descripTextView;

@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleTextField.layer.borderWidth = 0.5;
    self.priorityTextField.layer.borderWidth = 0.5;
    self.descripTextView.layer.borderWidth = 0.5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButton:(UIButton *)sender {

    [self makeNewToDo];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)makeNewToDo {
    
    if(![self.titleLabel.text isEqualToString: @""] && ![self.priorityTextField.text isEqualToString: @""] && ![self.descripTextView.text isEqualToString: @""] ) {
        
        ToDo *myToDo = [[ToDo alloc] initWithTitle:self.titleTextField.text
                                    andDescription:self.descripTextView.text
                                       andPriority:[self.priorityTextField.text intValue]
                                    andIsCompleted:NO];
        [self.delegate addToDo:myToDo];
    }
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(makeNewToDo) name:UITextFieldTextDidChangeNotification object:nil];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.view endEditing:YES];
    
    [self makeNewToDo];
    
    return NO;
}


- (void)keyboardWillShow:(NSNotification *)notification
{
    [self.view setFrame:CGRectMake(0,-110,self.view.frame.size.width,self.view.frame.size.height)];
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [self.view setFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.titleTextField resignFirstResponder];
    [self.priorityTextField resignFirstResponder];
    [self.descripTextView resignFirstResponder];
}

@end
