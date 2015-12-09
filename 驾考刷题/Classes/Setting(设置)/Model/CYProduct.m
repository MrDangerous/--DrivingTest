//
//  CYProduct.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/8.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYProduct.h"

@implementation CYProduct

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.icon = dict[@"icon"];
        self.title = dict[@"title"];
        self.identifier = dict[@"id"];
        self.schenes = dict[@"customUrl"];
        self.appUrl = dict[@"url"];
    }
    return self;
}

+(instancetype)productWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

@end
