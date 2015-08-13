//
//  ViewController.m
//  NumberWithComma
//
//  Created by FrankLiu on 15/8/11.
//  Copyright (c) 2015年 FrankLiu. All rights reserved.
//

#import "ViewController.h"
#import "NSString+NumberWithComma.h"

@interface ViewController ()<UITextFieldDelegate>


@property (strong, nonatomic) IBOutlet UILabel *showLabel;

@property (strong, nonatomic) IBOutlet UITextField *textField;

@end

// 输入框加上动画


@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAction:(id)sender {
    
    self.showLabel.text = [_textField.text numberWithComma:_textField.text];
    [_textField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    self.showLabel.text = [textField.text numberWithComma:textField.text];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return NO;

}

#pragma mark -

@end
