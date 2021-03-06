//
//  GMSpaceDogNode.m
//  Space Cat 5.1.1
//
//  Created by ED on 6/12/15.
//  Copyright (c) 2015 SwiftBeard. All rights reserved.
//

#import "GMSpaceDogNode.h"
#import "GMUtil.h"

@implementation GMSpaceDogNode


+ (instancetype) spaceDogType:(GMSpaceDogType)type
{
    GMSpaceDogNode *spaceDog;
    spaceDog.damaged = NO;
    
    NSArray *textures;
    
    if (type == GMSpaceDogTypeA) {
        spaceDog = [self spriteNodeWithImageNamed:@"spacedog_A_1"];
        textures = @[[SKTexture textureWithImageNamed:@"spacedog_A_1"],
                     [SKTexture textureWithImageNamed:@"spacedog_A_2"]];
        
        spaceDog.type = GMSpaceDogTypeA;
    } else {
        spaceDog = [self spriteNodeWithImageNamed:@"spacedog_B_1"];
        textures = @[[SKTexture textureWithImageNamed:@"spacedog_B_1"],
                     [SKTexture textureWithImageNamed:@"spacedog_B_2"],
                     [SKTexture textureWithImageNamed:@"spacedog_B_3"]];
        spaceDog.type = GMSpaceDogTypeB;
    }
    
    float scale = [GMUtil randomWithMin:85 max:100] / 100.0f;
    spaceDog.xScale = scale;
    spaceDog.yScale = scale;
    
    
    
    SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    
    [spaceDog runAction:[SKAction repeatActionForever:animation]withKey:@"animation"];
    
    [spaceDog setupPhysicsBody];
    
    return spaceDog;
}

- (BOOL) isDamaged
{
    NSArray *textures;
    
    if (!_damaged) {
        
        [self removeActionForKey:@"animation"];
        
        if (self.type == GMSpaceDogTypeA) {
            textures = @[[SKTexture textureWithImageNamed:@"spacedog_A_3"]];
        } else {
            textures = @[[SKTexture textureWithImageNamed:@"spacedog_B_4"]];
        }
        
        SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.1];
        [self runAction:[SKAction repeatActionForever:animation] withKey:@"damage_animation"];
        
        _damaged = YES;
        
        return NO;
    }
    
    return _damaged;
}

- (void) setupPhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    
    self.physicsBody.categoryBitMask = GMCollisionCategoryEnemy;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = GMCollisionCategoryProjectile | GMCollisionCategoryGround;  // 0010 | 1000 = 1010
    
}

@end
