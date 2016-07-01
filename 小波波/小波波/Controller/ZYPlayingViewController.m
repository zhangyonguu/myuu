//
//  ZYPlayingViewController.m
//  小波波
//
//  Created by tarena on 16/6/2.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZYPlayingViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ZYMusic.h"
#import "ZYMusicTool.h"
#import "ZYAudioTool.h"
#import "UIView+Extension.h"
@interface ZYPlayingViewController ()<AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *songNameLabel;
//专辑封面
@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;
//歌词表视图
@property (weak, nonatomic) IBOutlet UITableView *lrcTableView;
//当前播放时长
@property (weak, nonatomic) IBOutlet UILabel *currentDurationLabel;
//歌曲总时长
@property (weak, nonatomic) IBOutlet UILabel *totalDurationLabel;
//sliderControl
@property (weak, nonatomic) IBOutlet UISlider *sliderControl;
//播放按钮
@property (weak, nonatomic) IBOutlet UIButton *playButton;
//词/图切换按钮
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
//player对象
@property (nonatomic, strong) AVAudioPlayer *player;
//定时器
@property (nonatomic, strong) NSTimer *progressTimer;

@property (nonatomic, strong) ZYMusic *lastMusic;
//记录歌词可变数组
@property (nonatomic, strong) NSMutableArray *lrcContentArray;
//记录歌词对应每行时间数组
@property (nonatomic, strong) NSMutableArray *lrcTimeArray;
@end

@implementation ZYPlayingViewController

- (IBAction)clickBackButton:(UIButton *)sender {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [UIView animateWithDuration:1 animations:^{
        self.view.y = window.height;
    }];
}
- (IBAction)clickChangeButton:(UIButton *)sender
{
    
}
- (IBAction)clickPlayButton:(UIButton *)sender
{
    self.playButton.selected = !self.playButton.selected;
    ZYMusic *music = [ZYMusicTool getPlayingMusic];
    self.playButton.selected ? [ZYAudioTool playMusicWithFileName:music.filename] : [ZYAudioTool pauseMusicWithFileName:music.filename];
}

- (IBAction)clickPreviousButton:(UIButton *)sender {
   
    [self.progressTimer invalidate];
    self.progressTimer = nil;
    [ZYMusicTool setPlayingMusic:[ZYMusicTool previousMusic]];
    [self startPlayingMusic];
}

- (IBAction)clickNextButton:(id)sender
{
    [self.progressTimer invalidate];
    self.progressTimer = nil;
    [ZYMusicTool setPlayingMusic:[ZYMusicTool nextMusic]];
    [self startPlayingMusic];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showPlayingView
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.view.frame = window.bounds;
    [window addSubview:self.view];

    [self setShowThings];
    self.view.y = window.height;
    [UIView animateWithDuration:1 animations:^{
        self.view.y = 0;
    } completion:^(BOOL finished) {
        //
        [self startPlayingMusic];
    }];
}

-(void)setShowThings
{
    ZYMusic *music = [ZYMusicTool getPlayingMusic];
    self.songNameLabel.text = music.name;
    [self.playButton setSelected:YES];
    self.albumImageView.image = [UIImage imageNamed:music.icon];
    self.albumImageView.hidden = NO;
}

-(void)startPlayingMusic
{
    ZYMusic *music = [ZYMusicTool getPlayingMusic];
    if (self.lastMusic && self.lastMusic != music) {
        [ZYAudioTool stopMusicWithFileName:self.lastMusic.filename];
        [self setShowThings];
    }

    self.lastMusic = music;
    self.player = [ZYAudioTool playMusicWithFileName:music.filename];
    self.player.delegate = self;
    self.totalDurationLabel.text = [self stringFormatWithTimeInterval:_player.duration];
    
    [self addProgressTimer];
    [self addTargetToSlider];
}

-(void)addProgressTimer
{
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCurrentSlideValue) userInfo:nil repeats:YES];
}


-(void)updateCurrentSlideValue
{
    self.currentDurationLabel.text = [self stringFormatWithTimeInterval:_player.currentTime];
    self.sliderControl.value = self.player.currentTime / self.player.duration;
}

-(void)addTargetToSlider
{
    [self.sliderControl addTarget:self action:@selector(sliderTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [self.sliderControl addTarget:self action:@selector(sliderTouchDown) forControlEvents:UIControlEventTouchDown];
}

-(void)sliderTouchUpInside
{
    self.player.currentTime = self.sliderControl.value * self.player.duration;
    self.currentDurationLabel.text = [self stringFormatWithTimeInterval:self.player.currentTime];
    if (self.player.playing) {
        [self addProgressTimer];
    }
}

-(void)sliderTouchDown
{
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}

-(NSString *)stringFormatWithTimeInterval:(NSTimeInterval)interval
{
    int minute = interval / 60;
    int second = (int)interval % 60;
    return [NSString stringWithFormat:@"%02d:%02d",minute, second];
}


#pragma mark -AVAudioPlayerDelegate
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self clickNextButton:nil];
}

@end
