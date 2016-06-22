//
//  MainViewController.m
//  音乐播放器
//
//  Created by 张张张小烦 on 16/3/22.
//  Copyright © 2016年 张张张小烦. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showView.layer.cornerRadius = 140;
    self.showView.layer.masksToBounds = YES;
    
    //歌曲图片对象列表
    self.images = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"Childhood"],[UIImage imageNamed:@"Love"],[UIImage imageNamed:@"Try Everything"],[UIImage imageNamed:@"我无所谓"], nil];
    NSString *pathOne = [[NSBundle mainBundle] pathForResource:@"Childhood" ofType:@"mp3"];
    NSData *dataOne = [[NSFileManager defaultManager] contentsAtPath:pathOne];
    NSString *pathTwo = [[NSBundle mainBundle] pathForResource:@"Love" ofType:@"mp3"];
    NSData *dataTwo = [[NSFileManager defaultManager] contentsAtPath:pathTwo];
    NSString *pathThree = [[NSBundle mainBundle] pathForResource:@"Try Everything" ofType:@"mp3"];
    NSData *dataThree = [[NSFileManager defaultManager] contentsAtPath:pathThree];
    NSString *pathFour = [[NSBundle mainBundle] pathForResource:@"我无所谓" ofType:@"mp3"];
    NSData *dataFour = [[NSFileManager defaultManager] contentsAtPath:pathFour];
    //歌曲对象列表
    self.songs = [[NSArray alloc] initWithObjects:dataOne,dataTwo,dataThree,dataFour, nil];
    //默认播放第几首歌曲 显示第几张图片
    current = 0;
    player = [[AVAudioPlayer alloc] initWithData:self.songs[current] error:nil];
    self.showView.image = self.images[current];
    
    //设置播放器代理  后面要使用播放完毕的行为
    player.delegate = self;
    //设定当前音量
    player.volume = 0.2;
    //让音量条的值等于当前音量
    self.volmueSlider.value = player.volume;
    //歌曲总播放时间 player.duration
    //已经播放时间 player.deviceCurrentTime
    //创建定时器，以便及时得到当前播放位置
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    
}
//定时器事件
- (void)onTimer:(NSTimer *) sender {
    //NSLog(@"zong = %g,current = %g",player.duration,player.currentTime);
    self.progressSlider.value = player.currentTime;
}
//前一首
- (IBAction)frontTap:(UIButton *)sender {
    if (current == 0) {
        return;
    }
    else {
        current --;
    }
    player = [[AVAudioPlayer alloc] initWithData:self.songs[current] error:nil];
    self.showView.image = self.images[current];
    //设置进度条的最大最小值
    self.progressSlider.maximumValue = player.duration;
    self.progressSlider.minimumValue = 0;
    [player play];
    [self.playTap setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    flag = YES;
}
//播放
- (IBAction)playTap:(UIButton *)sender {
    if (!flag) {
        [player play];
        //设置进度条的最大最小值
        self.progressSlider.maximumValue = player.duration;
        self.progressSlider.minimumValue = 0;
        [sender setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        flag = YES;
    }
    else {
        [player stop];
        [sender setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        flag = NO;
    }
}
//下一首
- (IBAction)nextTap:(UIButton *)sender {
    if (current == self.songs.count-1) {
        return;
    }
    else {
        current ++;
    }
    player = [[AVAudioPlayer alloc] initWithData:self.songs[current] error:nil];
    self.showView.image = self.images[current];
    //设置进度条的最大最小值
    self.progressSlider.maximumValue = player.duration;
    self.progressSlider.minimumValue = 0;
    [player play];
    [self.playTap setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    flag = YES;
}
//音量调节
- (IBAction)volmueChanged:(UISlider *)sender {
    //让音量的大小等于当前调节的音量
    player.volume = sender.value;
}
//播放进度调整
- (IBAction)progressChanged:(UISlider *)sender {
    player.currentTime = sender.value;
}
//播放完毕
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [self.playTap setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    flag = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end






