//
//  NSString+NumberWithComma.m
//  NumberWithComma
//
//  Created by FrankLiu on 15/8/13.
//  Copyright (c) 2015年 FrankLiu. All rights reserved.
//

#import "NSString+NumberWithComma.h"

@implementation NSString (NumberWithComma)

- (NSString*)numberWithComma:(NSString*)numberString {
    
    // nil 返回@""
    if (!numberString) {
        
        return @"";
        // 如果含有","直接返回
    } else if ([numberString rangeOfString:@","].length >0) {
        
        return numberString;
    }
    
    // 以非0数字开头,可以包含小数点的数字
    NSString *regexStr = @"[1-9]\\d*.?\\d+";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self matches %@",regexStr];
    
    // 一些不符合基本数字规则的,直接返回
    if ([predicate evaluateWithObject:numberString] == NO) {
        
        return numberString;
    }
    
     /* 开始处理正常的数字字符串*/
    NSMutableArray *componentArray = [NSMutableArray array];
    
    // 如果有小数点
    if ([numberString rangeOfString:@"."].length != 0) {
        
        NSArray *separateArray = [numberString componentsSeparatedByString:@"."];
        
        // 如果是小数
        if (separateArray.count == 2) {
            
            [componentArray addObject:separateArray[1]];
            [componentArray addObject:@"."];
            
            // 否则直接返回
        } else {
            
            return numberString;
        }
    }
    
    long long number = [numberString longLongValue];
    
    // 分离各个整数位数字
    do {
        if (number/1000 >= 1) {
            
            for (int i = 0; i < 3; i++) {
                
                long long firstNumber = number%10;
                number /= 10;
                [componentArray addObject:[NSString stringWithFormat:@"%lld",firstNumber]];
            }
            [componentArray addObject:@","];
            
        } else {
            
            do {
                
                long long firstNumber = number%10;
                number /= 10;
                [componentArray addObject:[NSString stringWithFormat:@"%lld",firstNumber]];
                
            } while (number >= 1);
            
        }
        
        
    } while ( number >= 1);
    
    // 取出数组中字符
    NSMutableString *tempStr = [NSMutableString stringWithString:@""];
    
    for (int i = (int)componentArray.count-1; i >= 0; i--) {
        
        [tempStr appendString:componentArray[i]];
    }
    
    return tempStr;
}

@end
