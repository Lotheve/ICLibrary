//
//  ICAddressBookHelper.m
//  ICAddressBook
//
//  Created by Lotheve on 15/7/30.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import <AddressBook/AddressBook.h>
#import "ICAddressBookHelper.h"
#import "UserTableSection.h"

@interface ICAddressBookHelper ()

/**
 *  成功句柄
 */
@property (strong, nonatomic)ICSuccessAddressContactsBlock successBlock;

/**
 *  分组成功句柄
 */
@property (strong, nonatomic)ICSuccessAddressGroupBlock successGroupBlock;

/**
 *  失败句柄
 */
@property (strong, nonatomic)ICFailedAddressContractsBlock failedBlock;

@end

@implementation ICAddressBookHelper{
    ABAddressBookRef _addressBook;
    UserTableSection * _userSectionArray;
}

+ (ICAddressBookHelper*)shareInstance{
    static ICAddressBookHelper *addressBookHelper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        addressBookHelper = [[ICAddressBookHelper alloc]init];
    });
    return addressBookHelper;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)getContactsWithSuccessFn:(ICSuccessAddressContactsBlock)successFn FailedFn:(ICFailedAddressContractsBlock)failedFn{
    self.successBlock = successFn;
    self.failedBlock = failedFn;
    if ([self accessTheAddress]) {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in [self getAddressArray]) {
            User *user = [User createWithDictionary:dic];
            if (user) {
                [array addObject:user];
            }
        }
        if (self.successBlock) {
            self.successBlock(array);
        }
    }
}

- (void)getContactsByGroupWithSuccessFn:(ICSuccessAddressGroupBlock)successFn
                               FailedFn:(ICFailedAddressContractsBlock)failedFn{
    self.successGroupBlock = successFn;
    self.failedBlock = failedFn;
    
    if ([self accessTheAddress]) {
        NSMutableArray *array = [self getAddressArray];
        _userSectionArray = [UserTableSection createWithSourceArray:array];
        if (self.successGroupBlock) {
            self.successGroupBlock(_userSectionArray.sectionTitles, _userSectionArray.setionItems, _userSectionArray.unsortedArray.count);
        }
    }
}

//获取访问权限
- (BOOL)accessTheAddress{
    
    __block BOOL isGranted;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        CFErrorRef cferror = nil;  //!!!:如果只定义不赋nil 释放时会报错
        _addressBook = ABAddressBookCreateWithOptions(NULL, &cferror);
        NSError *error = CFBridgingRelease(cferror);
        if (error) {
            if (self.failedBlock) {
                self.failedBlock(error, @"获取通讯录权限失败!");
            }
            return NO;
        }
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);  //创建同步信号量
        ABAddressBookRequestAccessWithCompletion(_addressBook, ^(bool granted, CFErrorRef error) {
            if (!granted) {
                //未授权
                if (self.failedBlock) {
                    NSError *err = (__bridge NSError *)error;
                    self.failedBlock(err, @"获取通讯录权限失败!");
                }
                isGranted = NO;
            }else{
                //授权
                isGranted = YES;
            }
            dispatch_semaphore_signal(sema);  //发送一次信号量
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER); //等待授权结果
    }
    else{
        _addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        isGranted = YES;
    }
    return isGranted;
}

#pragma mark- Private method

/**
 *  获取通讯录数据
 *
 *  @return 转化数据，返回数组
 */
- (NSMutableArray*)getAddressArray{
    //将获取的数据转化为出来
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    NSArray *addressArray = CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(_addressBook));
    for(id object in addressArray){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        
        ABRecordRef record = CFBridgingRetain(object);
        //获取通讯录中的名字
        NSString *firstName = CFBridgingRelease(ABRecordCopyValue(record, kABPersonFirstNameProperty));
        if (firstName) {
            [dic setObject:firstName forKey:@"firstName"];
        }
        //获取通讯录中的姓氏
        NSString *lastName = CFBridgingRelease(ABRecordCopyValue(record, kABPersonLastNameProperty));
        if (lastName) {
            [dic setObject:lastName forKey:@"lastName"];
        }
        //获取通讯录中的中间名
        NSString *middleName = CFBridgingRelease(ABRecordCopyValue(record, kABPersonMiddleNameProperty));
        if (middleName) {
            [dic setObject:middleName forKey:@"middleName"];
        }
        //获取通讯录中的前缀
        NSString *prefixProperty = CFBridgingRelease(ABRecordCopyValue(record, kABPersonPrefixProperty));
        if (prefixProperty) {
            [dic setObject:prefixProperty forKey:@"prefixProperty"];
        }
        //获取通讯录中的后缀
        NSString *suffixProperty = CFBridgingRelease(ABRecordCopyValue(record, kABPersonSuffixProperty));
        if (suffixProperty) {
            [dic setObject:suffixProperty forKey:@"suffixProperty"];
        }
        //获取通讯录中的昵称
        NSString *nickName = CFBridgingRelease(ABRecordCopyValue(record, kABPersonNicknameProperty));
        if (nickName) {
            [dic setObject:nickName forKey:@"nickName"];
        }
        //获取通讯录中的组织名
        NSString *organizationProperty = CFBridgingRelease(ABRecordCopyValue(record, kABPersonOrganizationProperty));
        if (organizationProperty) {
            [dic setObject:organizationProperty forKey:@"organizationProperty"];
        }
        //获取通讯录中的头衔
        NSString *jobTitleProperty = CFBridgingRelease(ABRecordCopyValue(record, kABPersonJobTitleProperty));
        if (jobTitleProperty) {
            [dic setObject:jobTitleProperty forKey:@"jobTitleProperty"];
        }
        //获取通讯录中的部门
        NSString *departmentProperty = CFBridgingRelease(ABRecordCopyValue(record, kABPersonDepartmentProperty));
        if (departmentProperty) {
            [dic setObject:departmentProperty forKey:@"departmentProperty"];
        }
        //获取通讯录中的备注
        NSString *noteProperty = CFBridgingRelease(ABRecordCopyValue(record, kABPersonNoteProperty));
        if (noteProperty) {
            [dic setObject:noteProperty forKey:@"noteProperty"];
        }
        //获取通讯录中的email地址
        CFArrayRef Emailarray = ABRecordCopyValue(record, kABPersonEmailProperty);
        NSArray *emails = CFBridgingRelease(ABMultiValueCopyArrayOfAllValues(Emailarray));
        if (emails) {
            [dic setObject:emails forKey:@"emails"];
        }
        //获取通讯录中的电话
        CFArrayRef phonearray = ABRecordCopyValue(record, kABPersonPhoneProperty);
        NSArray *phones = CFBridgingRelease(ABMultiValueCopyArrayOfAllValues(phonearray));
        if (phones) {
            [dic setObject:phones forKey:@"phones"];
        }
        CFRelease(record);
        
        [tempArray addObject:dic];
    }
    
    CFRelease(_addressBook);

    return tempArray;
}


/* 参考
 kABPersonFirstNameProperty，名字
 kABPersonLastNameProperty，姓氏
 kABPersonMiddleNameProperty，中间名
 kABPersonPrefixProperty，前缀
 kABPersonSuffixProperty，后缀
 kABPersonNicknameProperty，昵称
 kABPersonFirstNamePhoneticProperty，名字汉语拼音或音标
 kABPersonLastNamePhoneticProperty，姓氏汉语拼音或音标
 kABPersonMiddleNamePhoneticProperty，中间名汉语拼音或音标
 kABPersonOrganizationProperty，组织名
 kABPersonJobTitleProperty，头衔
 kABPersonDepartmentProperty，部门
 kABPersonNoteProperty，备注
 
 kABPersonPhoneProperty，电话号码属性，kABMultiStringPropertyType类型多值属性；
 kABPersonEmailProperty，Email属性，kABMultiStringPropertyType类型多值属性；
 kABPersonURLProperty，URL属性，kABMultiStringPropertyType类型多值属性；
 kABPersonRelatedNamesProperty，亲属关系人属性，kABMultiStringPropertyType类型多值属性；
 kABPersonAddressProperty，地址属性，kABMultiDictionaryPropertyType类型多值属性；
 kABPersonInstantMessageProperty，即时聊天属性，kABMultiDictionaryPropertyType类型多值属性；
 kABPersonSocialProfileProperty，社交账号属性，kABMultiDictionaryPropertyType类型多值属性；
 */
@end
