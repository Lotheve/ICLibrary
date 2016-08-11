//
//  JLNameItem.m
//  JLNameSectionSort
//
//  Created by jimney on 13-3-12.
//  Copyright (c) 2013年 jimneylee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLNameItem : NSObject

@property (nonatomic, copy) NSString* name;      //全名
@property (nonatomic, copy) NSString* sortString;// 供排序所用字串
@property (nonatomic) unichar firstLetter;       // 首字母

- (NSString* )createSortString;

@end
