//
//  ZYMusicTool.h
//  小波波
//
//  Created by tarena on 16/6/2.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYMusic.h"
@interface ZYMusicTool : NSObject
+ (NSArray *)getMusicArray;

+(void)setPlayingMusic:(ZYMusic *)music;
+(ZYMusic *)getPlayingMusic;

+(ZYMusic *)previousMusic;
+(ZYMusic *)nextMusic;
@end
