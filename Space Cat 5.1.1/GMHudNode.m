//
//  GMHudNode.m
//  Space Cat 5.1.1
//
//  Created by ED on 6/13/15.
//  Copyright (c) 2015 SwiftBeard. All rights reserved.
//

#import "GMHudNode.h"
#import "GMUtil.h"

@implementation GMHudNode


+ (instancetype) hudAtPosition:(CGPoint)position
{
    GMHudNode *hud = [self node];
    hud.position = position;
    hud.zPosition = 10;
    
    
    SKSpriteNode *catHead = [SKSpriteNode spriteNodeWithImageNamed:@"HUD_cat_1"];
    catHead.position = CGPointMake(20, -10);
    [hud addChild:catHead];
    
    hud.lives = GMMaxLives;
    SKSpriteNode *lastLifeBar;
    
    for (int i=0; i < hud.lives; i++) {
        SKSpriteNode *lifeBar = [SKSpriteNode spriteNodeWithImageNamed:@"HUD_life_1"];
        lifeBar.name = [NSString stringWithFormat:@"Life%d", i+1];
        
        [hud addChild:lifeBar];
        
        if (lastLifeBar == nil ) {
            lifeBar.position = CGPointMake(catHead.position.x+30, catHead.position.y);
        } else {
            lifeBar.position = CGPointMake(catHead.position.x+10, catHead.position.y);
        }
    }
    
    
    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    scoreLabel.name = @"Score";
    scoreLabel.text = @"0";
    scoreLabel.fontSize = 24;
    scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    scoreLabel.position = CGPointMake(hud.parent.frame.size.width-20, -10);
    [hud addChild:scoreLabel];
    return hud;
}
@end
