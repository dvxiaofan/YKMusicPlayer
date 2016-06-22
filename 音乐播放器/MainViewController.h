//
//  MainViewController.h
//  音乐播放器
//
//  Created by 张张张小烦 on 16/3/22.
//  Copyright © 2016年 张张张小烦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MainViewController : UIViewController <AVAudioPlayerDelegate>
{
    AVAudioPlayer *player;
    int current;//当前播放歌曲的号码 从0开始
    BOOL flag;//播放按钮标识 区分按钮状态
}
@property (strong, nonatomic) NSArray *images;
@property (strong, nonatomic) NSArray *songs;
@property (weak, nonatomic) IBOutlet UIImageView *showView;


@property (weak, nonatomic) IBOutlet UISlider *volmueSlider;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UIButton *playTap;


- (IBAction)frontTap:(UIButton *)sender;
- (IBAction)playTap:(UIButton *)sender;
- (IBAction)nextTap:(UIButton *)sender;
- (IBAction)volmueChanged:(UISlider *)sender;
- (IBAction)progressChanged:(UISlider *)sender;






@end
