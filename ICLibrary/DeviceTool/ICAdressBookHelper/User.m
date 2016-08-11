//
//  User.m
//  JLNameSectionSort
//
//  Created by jimney on 13-3-12.
//  Copyright (c) 2013年 jimneylee. All rights reserved.
//

#import "User.h"
#import "pinyin.h"

@implementation User

- (id)initWithName:(NSString*)name
{
    self = [super init];
    if (self) {
        if (name.length > 0) {
            self.name = name;
            self.sortString = [super createSortString];
        }
    }
    return self;
}


+ (id)createWithDictionary:(NSDictionary*)dic
{
    if (!dic || !dic.count) {
        return nil;
    }
    
	User* entity = [[User alloc] init];
    // 其他属性
    entity.firstName = dic[@"firstName"];
    entity.lastName = dic[@"lastName"];
    entity.middleName = dic[@"middleName"];
    entity.prefixProperty = dic[@"prefixProperty"];
    entity.suffixProperty = dic[@"suffixProperty"];
    entity.nickName = dic[@"nickName"];
    entity.organizationProperty = dic[@"organizationProperty"];
    entity.jobTitleProperty = dic[@"jobTitleProperty"];
    entity.departmentProperty = dic[@"departmentProperty"];
    entity.noteProperty = dic[@"noteProperty"];
    entity.emailsemail = dic[@"emailsemail"];
    entity.phones = dic[@"phones"];
    NSMutableString *name = [[NSMutableString alloc]init];
    if (entity.lastName) {
        [name appendString:entity.lastName];
    }
    if (entity.firstName) {
        [name appendString:entity.firstName];
    }
    entity.name = [NSString stringWithFormat:@"%@", name];    
    if (entity.name.length > 0) {
        entity.sortString = [entity createSortString];
        return entity;
    }
    else return nil;
}

@end
