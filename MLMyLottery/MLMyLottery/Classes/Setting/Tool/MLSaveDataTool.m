
//
//  MLSaveDataTool.m
//  MLMyLottery
//
//  Created by tarena on 16/4/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MLSaveDataTool.h"

@implementation MLSaveDataTool

+(id)objectForKey:(NSString *)defaultName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];

}

+(void)setObject:(id)value forKey:(NSString *)defaultName
{
    [[NSUserDefaults standardUserDefaults] setObject:value  forKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
