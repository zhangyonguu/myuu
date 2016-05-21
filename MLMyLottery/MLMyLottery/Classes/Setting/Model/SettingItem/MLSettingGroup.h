//
//  MLSettingGroup.h
//  MLMyLottery
//
//  Created by tarena on 16/4/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLSettingGroup : NSObject
@property (nonatomic, copy) NSString *header;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NSString *footer;

@end
