//
//  MLHelp.h
//  MLMyLottery
//
//  Created by tarena on 16/4/23.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLHelp : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *html;

+(instancetype)helpWithDict:(NSDictionary *)dict;
@end
