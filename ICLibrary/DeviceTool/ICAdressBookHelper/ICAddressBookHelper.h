//
//  ICAddressBookHelper.h
//  ICAddressBook
//
//  Created by Lotheve on 15/7/30.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

/*!
 *  获取手机的通讯录联系人信息的工具类，支持获取未排序数据和已分组数据
 */

#import <Foundation/Foundation.h>
#import "User.h"

/**
 *  获取通讯录列表成功回调block(未排序)
 */
typedef void(^ICSuccessAddressContactsBlock)(NSMutableArray<User *> *contacts);


/**
 *  获取通讯录列表成功回调block(已分组)
 *
 *  @param indexsOfGroup   分组索引数组
 *  @param groups    分组数组 每个分组包含的对象为User类型
 */
typedef void(^ICSuccessAddressGroupBlock)(NSMutableArray *indexsOfGroup, NSMutableArray *groups, NSUInteger count);

/**
 *  获取通讯录失败回调block
 */
typedef void(^ICFailedAddressContractsBlock)(NSError *error, NSString *desc);


@interface ICAddressBookHelper : NSObject

+ (ICAddressBookHelper*)shareInstance;

/**
 *  同步获取通讯录列表(未排序未分组)
 *
 *  @param successFn 成功回调
 *  @param failedFn  失败回调
 */
- (void)getContactsWithSuccessFn:(ICSuccessAddressContactsBlock)successFn
                        FailedFn:(ICFailedAddressContractsBlock)failedFn;

/**
 *  同步获取通讯录（按首字母分组）列表
 *
 *  @param successFn 成功回调
 *  @param failedFn  失败回调
 */
- (void)getContactsByGroupWithSuccessFn:(ICSuccessAddressGroupBlock)successFn
                               FailedFn:(ICFailedAddressContractsBlock)failedFn;
@end
