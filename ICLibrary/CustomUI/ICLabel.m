//
//  ICLabel.m
//  ICGeneral
//
//  Created by Lotheve on 15/7/20.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "ICLabel.h"

@implementation NSArray (ICLabel)
+ (instancetype)rangeArrayWithLocationAndLength:(id)firstObject, ...{
    //获取object
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    if (tempArray) {
        va_list argList;
        if (firstObject) {
            [tempArray addObject:firstObject];
            va_start(argList, firstObject);
            id arg;
            while ((arg = va_arg(argList, id))) {
                [tempArray addObject:arg];
            }
        }
    }
    //符合条件,转化
    NSMutableArray *array = nil;
    if (!([tempArray count]%2)) {
        array = [[NSMutableArray alloc]init];
        for (int i=0; i<[tempArray count]; i+=2) {
            NSUInteger location = [(NSNumber*)[tempArray objectAtIndex:i] unsignedIntegerValue];
            NSUInteger lenght = [(NSNumber*)[tempArray objectAtIndex:i+1] unsignedIntegerValue];
            NSString *str = NSStringFromRange(NSMakeRange(location, lenght));
            [array addObject:str];
        }
    }
    
    return [NSArray arrayWithArray:array];
}
@end


@implementation ICLabel
- (void)setDeleteLineInRanges:(NSArray*)ranges{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];;
    if (!attributedStr) return;
    
    for (NSString *rangeStr in ranges) {
        if (!rangeStr) continue;
        
        NSRange range = NSRangeFromString(rangeStr);
        [attributedStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithUnsignedInteger:NSUnderlineStyleSingle] range:range];
    }
    self.attributedText = attributedStr;
}

- (void)setFont:(UIFont*)font inRanges:(NSArray*)ranges{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];;
    if (!attributedStr) return;
    
    for (NSString *rangeStr in ranges) {
        if (!rangeStr) continue;
        
        NSRange range = NSRangeFromString(rangeStr);
        [attributedStr addAttribute:NSFontAttributeName value:font range:range];
    }
    self.attributedText = attributedStr;
}

- (void)setColor:(UIColor*)color inRanges:(NSArray*)ranges{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];;
    if (!attributedStr) return;
    
    for (NSString *rangeStr in ranges) {
        if (!rangeStr) continue;
        
        NSRange range = NSRangeFromString(rangeStr);
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    self.attributedText = attributedStr;
}

#pragma mark- Private method
- (void)setText:(NSString *)text{
    [super setText:text];
    
    self.attributedText = [[NSAttributedString alloc]initWithString:text];
}

@end
