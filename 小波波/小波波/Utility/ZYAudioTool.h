//
//  ZYAudioTool.h
//  小波波
//
//  Created by tarena on 16/6/2.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface ZYAudioTool : NSObject
+(AVAudioPlayer *)playMusicWithFileName:(NSString *)fileName;
+(void)pauseMusicWithFileName:(NSString *)fileName;
+(void)stopMusicWithFileName:(NSString *)fileName;
@end
