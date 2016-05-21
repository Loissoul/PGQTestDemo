//
//  PGQVideoViewController.m
//  PGQTestDemo
//
//  Created by Lois_pan on 16/2/29.
//  Copyright © 2016年 潘国强. All rights reserved.
//

#import "PGQVideoViewController.h"
#import "PGQVideoFunctions.h"

@interface PGQVideoViewController ()

@property (nonatomic, strong) MPMoviePlayerController * player;
@property (nonatomic, assign) BOOL isLoop;

@end

@implementation PGQVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([PGQVideoFunctions getUrlInfo] != nil) {
        self.isLoop = [PGQVideoFunctions getLoopMode];
        [self preparePlaybcak];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self getPlayerNotifications];
    
    [self.player play];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [self.player pause];
}

#pragma mark -Player

- (void)getPlayerNotifications{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayerStateChangeNotification:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
}

- (void)preparePlaybcak{
    if (self.player == nil) {
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[PGQVideoFunctions getVideoUrl] ofType:[PGQVideoFunctions getVideoType]]];
        self.player = [[MPMoviePlayerController alloc] initWithContentURL:url];
        [self.player setControlStyle:MPMovieControlStyleNone];
        [self.player prepareToPlay];
        [self.player.view setFrame:self.view.frame];
        [self.view addSubview:self.player.view];
        [self.view sendSubviewToBack:self.player.view];
        self.player.scalingMode = MPMovieScalingModeAspectFill;
    }
}

- (void)videoPlayerStateChangeNotification:(NSNotification *)notification{
    MPMoviePlayerController * moviePlayer = notification.object;
    MPMoviePlaybackState  playbackState = moviePlayer.playbackState;
    
    switch (playbackState) {
        case MPMoviePlaybackStatePaused:
        case MPMoviePlaybackStateStopped:
        case MPMoviePlaybackStateInterrupted:{
        
            if (self.isLoop) {
                moviePlayer.controlStyle = MPMovieControlStyleNone;
                [self.player play];
            }
        }
            break;
            
        default:
            break;
    }
}

@end
