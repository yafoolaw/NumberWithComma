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


@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAction:(id)sender {
    
    // 处理并展示输入的字符串
    self.showLabel.text = [NSString numberWithComma:_textField.text];
    [_textField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    // 处理并展示输入的字符串
    self.showLabel.text = [NSString numberWithComma:textField.text];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return NO;

}

#pragma mark -

@end
