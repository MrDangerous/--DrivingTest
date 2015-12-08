//
//  CYSettingItem.h
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/8.
//  Copyright © 2015年 john. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYSettingItem : NSObject
@property(nonatomic, copy)NSString *icon;
@property(nonatomic, copy)NSString *title;

-(instancetype)initWithIcon:(NSString *)icon title:(NSString *)title;
+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;

@end
