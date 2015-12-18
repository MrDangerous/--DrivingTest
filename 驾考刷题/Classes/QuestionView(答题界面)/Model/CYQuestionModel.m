//
//  CYQuestionModel.m
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/12.
//  Copyright © 2015年 john. All rights reserved.
//

#import "CYQuestionModel.h"
#import "MJExtension.h"

@interface CYQuestionModel()<NSCoding>

@end

@implementation CYQuestionModel
/**
 *  给题目加题号
 */
-(void)setQuestion:(NSString *)question
{
    _question =[NSString stringWithFormat:@"  %ld. %@",(long)self.id,question];

}
+ (instancetype)modelWithDict:(NSDictionary *)dict {
    CYQuestionModel *model = [[CYQuestionModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
/**
 *  从文件中解析数据的时候调用
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        //必须要存入对象，所以要想转为对象
        NSNumber *number = [NSNumber numberWithInteger:self.id];
        number  = [aDecoder decodeObjectForKey:@"id"];
        self.question = [aDecoder decodeObjectForKey:@"question"];
        self.answer = [aDecoder decodeObjectForKey:@"answer"];
        self.item1 = [aDecoder decodeObjectForKey:@"item1"];
        self.item2 = [aDecoder decodeObjectForKey:@"item2"];
        self.item3 = [aDecoder decodeObjectForKey:@"item3"];
        self.explains = [aDecoder decodeObjectForKey:@"explains"];
        self.url = [aDecoder decodeObjectForKey:@"url"];
        NSNumber *boolNumber = [NSNumber numberWithBool:self.isCollection];
        boolNumber = [aDecoder decodeObjectForKey:@"isCollection"];

    }
    return self;

}
/**
 *  写入文件的时候调用
 */
-(void)encodeWithCoder:(NSCoder *)aCoder
{
        NSNumber *number = [NSNumber numberWithInteger:self.id];
        [aCoder encodeObject:number forKey:@"id"];
        [aCoder encodeObject:self.question forKey:@"question"];
        [aCoder encodeObject:self.answer forKey:@"answer"];
        [aCoder encodeObject:self.item1 forKey:@"item1"];
        [aCoder encodeObject:self.item2 forKey:@"item2"];
        [aCoder encodeObject:self.item3 forKey:@"item3"];
        [aCoder encodeObject:self.explains forKey:@"explains"];
        [aCoder encodeObject:self.url forKey:@"url"];
        NSNumber *boolNumber = [NSNumber numberWithBool:self.isCollection];
        [aCoder encodeObject:boolNumber forKey:@"isCollection"];
}
//明杰封装的宏，一句话搞定存储
//MJCodingImplementation
@end
