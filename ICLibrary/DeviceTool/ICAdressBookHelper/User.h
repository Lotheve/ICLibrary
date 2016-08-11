//
//  User.h
//  JLNameSectionSort
//
//  Created by jimney on 13-3-12.
//  Copyright (c) 2013年 jimneylee. All rights reserved.
//

#import "JLNameItem.h"

@interface User : JLNameItem

//其他属性
@property (strong, nonatomic) NSString *firstName;//名字
@property (strong, nonatomic) NSString *lastName;//姓氏
@property (strong, nonatomic) NSString *middleName;//中间名
@property (strong, nonatomic) NSString *prefixProperty;//前缀
@property (strong, nonatomic) NSString *suffixProperty;//后缀
@property (strong, nonatomic) NSString *nickName;//昵称
@property (strong, nonatomic) NSString *organizationProperty;//组织名
@property (strong, nonatomic) NSString *jobTitleProperty;//头衔
@property (strong, nonatomic) NSString *departmentProperty;//部门
@property (strong, nonatomic) NSString *noteProperty;//备注
@property (strong, nonatomic) NSArray  *emailsemail;//地址
@property (strong, nonatomic) NSArray  *phones;//电话

- (id)initWithName:(NSString*)name;
+ (id)createWithDictionary:(NSDictionary*)dic;

@end
