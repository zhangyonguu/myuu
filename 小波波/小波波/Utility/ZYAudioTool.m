//
//  ZYAudioTool.m
//  小波波
//
//  Created by tarena on 16/6/2.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZYAudioTool.h"

@implementation ZYAudioTool

static NSMutableDictionary *_playerDic = nil;
+(NSMutableDictionary *)getPlayerDic
{
    if (_playerDic == nil) {
        _playerDic = [NSMutableDictionary dictionary];
    }
    return _playerDic;
}

+(AVAudioPlayer *)playMusicWithFileName:(NSString *)fileName
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    AVAudioPlayer *player = [self getPlayerDic][url];
    NSError *error = nil;
    if (!player) {
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        if (!error) {
            _playerDic[url] = player;
        }
    }
    if (!player.playing) {
        [player play];
    }
    return player;
}

+(void)pauseMusicWithFileName:(NSString *)fileName
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    AVAudioPlayer *player = [self getPlayerDic][url];
    if (player) {
        if (player.playing) {
            [player pause];
        }
    }
}

+(void)stopMusicWithFileName:(NSString *)fileName
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    AVAudioPlayer *player = [self getPlayerDic][url];
    if (player) {
        [player stop];
        player.currentTime = 0;
    }
}
@end
