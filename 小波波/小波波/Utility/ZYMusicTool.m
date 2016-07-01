//
//  ZYMusicTool.m
//  小波波
//
//  Created by tarena on 16/6/2.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZYMusicTool.h"

@implementation ZYMusicTool

static NSArray *_musicArray = nil;
+ (NSArray *)getMusicArray {
    if (!_musicArray) {
        
        _musicArray = [ZYMusicTool getMusicArrayWithPlist:@"Musics.plist"];
    }
    return _musicArray;
}
+ (NSArray *)getMusicArrayWithPlist:(NSString *)plistName {
    //路径
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:nil];
    //获取数据
    NSArray *musicArray = [NSArray arrayWithContentsOfFile:plistPath];
    //循环字典->TRMusic
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dic in musicArray) {
        ZYMusic *music = [ZYMusic new];
        [music setValuesForKeysWithDictionary:dic];
        [mutableArray addObject:music];
    }
    return [mutableArray copy];
}

static ZYMusic *_playingMusic = nil;
+(void)setPlayingMusic:(ZYMusic *)music
{
    _playingMusic = music;
}

+(ZYMusic *)getPlayingMusic
{
    return _playingMusic;
}

+(ZYMusic *)nextMusic
{
    NSInteger index = [[self getMusicArray] indexOfObject:[self getPlayingMusic]];
    if (index == [self getMusicArray].count - 1) {
        index = 0;
    }
    else
    {
        index++;
    }
    return [self getMusicArray][index];
}

+(ZYMusic *)previousMusic
{
    NSInteger index = [[self getMusicArray] indexOfObject:[self getPlayingMusic]];
    if (index == 0) {
        index = [self getMusicArray].count - 1;
    }
    else
    {
        index--;
    }
    return [self getMusicArray][index];
}
@end
