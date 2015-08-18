//
//  NSString+StringOfNumberAddComma.m
//  NumberWithComma
//
//  Created by FrankLiu on 15/8/18.
//  Copyright (c) 2015年 FrankLiu. All rights reserved.
//

#import "NSString+StringOfNumberAddComma.h"

@implementation NSString (StringOfNumberAddComma)

- (NSString*)stringOfNumberAddComma {

    // nil 返回@""
    if (!self) {
        
        return @"";
        // 如果含有","直接返回
    } else if ([self rangeOfString:@","].length >0) {
        
        return self;
    }
    
    // 以"+","-",或非0数字开头,可以包含小数点的数字
    NSString *regexStr = @"[+-]?[1-9]\\d*.?\\d+";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self matches %@",regexStr];
    
    // 一些不符合基本数字规则的,直接返回
    if ([predicate evaluateWithObject:self] == NO) {
        
        return self;
    }
    
    /* 开始处理正常的数字字符串*/
    NSMutableArray *componentArray = [NSMutableArray array];
    
    // 如果有小数点
    if ([self rangeOfString:@"."].length != 0) {
        
        NSArray *separateArray = [self componentsSeparatedByString:@"."];
        
        // 如果是小数
        if (separateArray.count == 2) {
            
            [componentArray addObject:separateArray[1]];
            [componentArray addObject:@"."];
            
            // 否则直接返回
        } else {
            
            return self;
        }
    }
    
    // 如果以"+" "-"开头,暂时去掉
    BOOL hasPlusPrefix  = NO;
    BOOL hasMinusPrefix = NO;
    NSString *selfStr = self;
    
    if ([self hasPrefix:@"+"]) {
        
        hasPlusPrefix = YES;
        selfStr = [self substringFromIndex:1];
        
    } else if ([self hasPrefix:@"-"]){
        
        hasMinusPrefix = YES;
        selfStr = [self substringFromIndex:1];
    }
    
    long long number = [selfStr longLongValue];
    
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
    
    // 如果以"+" "-"开头,补上
    if (hasPlusPrefix) {
        
        return [NSString stringWithFormat:@"+%@",tempStr];
        
    } else if (hasMinusPrefix) {
        
        return [NSString stringWithFormat:@"-%@",tempStr];
    }
    
    return tempStr;
    
    
}

@end
