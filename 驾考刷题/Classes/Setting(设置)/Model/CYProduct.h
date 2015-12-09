//
//  CYProduct.h
//  驾考刷题
//
//  Created by 程俊亚 on 15/12/8.
//  Copyright © 2015年 john. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYProduct : NSObject
@property(nonatomic, copy)NSString *icon;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *identifier;
@property(nonatomic, copy)NSString *schenes;
@property(nonatomic, copy)NSString *appUrl;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)productWithDict:(NSDictionary *)dict;
@end
