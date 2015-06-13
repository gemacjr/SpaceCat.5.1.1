//
//  GMTitleScene.m
//  Space Cat 5.1.1
//
//  Created by ED on 6/12/15.
//  Copyright (c) 2015 SwiftBeard. All rights reserved.
//

#import "GMTitleScene.h"
#import "GMGamePlayScene.h"
#import <AVFoundation/AVFoundation.h>

@interface GMTitleScene ()

@property (nonatomic) SKAction *pressStartSFX;
@property (nonatomic) AVAudioPlayer *backgroundMusic;
@end

@implementation GMTitleScene


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"splash_1"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        [self addChild:background];
        
        self.pressStartSFX = [SKAction playSoundFileNamed:@"PressStart.caf" waitForCompletion:NO];
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"StartScreen" withExtension:@"mp3"];
        self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        self.backgroundMusic.numberOfLoops = -1;
        [self.backgroundMusic prepareToPlay];
    }
    return self;
}

- (void)didMoveToView:(SKView *)view
{
    [self.backgroundMusic play];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self runAction:self.pressStartSFX];
    
    [self.backgroundMusic stop];
    
    GMGamePlayScene *gamePlayScene = [GMGamePlayScene sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition fadeWithDuration:1.0];
    
    // different transitions
    [self.view presentScene:gamePlayScene transition:transition];
    
}
@end
