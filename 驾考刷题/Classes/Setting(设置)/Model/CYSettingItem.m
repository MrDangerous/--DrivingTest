//
//  CYSettingItem.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/8.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYSettingItem.h"

@implementation CYSettingItem
-(instancetype)initWithIcon:(NSString *)icon title:(NSString *)title
{
    if (self = [super init]) {
        self.icon = icon;
        self.title = title;
    }
    return self;
}
+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    return [[self alloc]initWithIcon:icon title:title];

}
+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title vcClass:(Class)vcClass
{
    CYSettingItem *item = [self itemWithIcon:icon title:title];
    item.vcClass = vcClass;

    return item;
}
@end
