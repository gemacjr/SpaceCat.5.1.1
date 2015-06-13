//
//  GMGroundNode.m
//  Space Cat 5.1.1
//
//  Created by ED on 6/13/15.
//  Copyright (c) 2015 SwiftBeard. All rights reserved.
//

#import "GMGroundNode.h"
#import "GMUtil.h"

@implementation GMGroundNode

+ (instancetype) groundWithSize:(CGSize)size
{
    GMGroundNode *ground = [self spriteNodeWithColor:[SKColor clearColor] size:size];
    ground.name = @"Ground";
    ground.position = CGPointMake(size.width/2, size.height/2);
    
    [ground setupPhysicsBody];
    
    
    return ground;
    
    
}

- (void) setupPhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.dynamic = NO;
    self.physicsBody.categoryBitMask = GMCollisionCategoryGround;
    self.physicsBody.collisionBitMask = GMCollisionCategoryDebris;
    self.physicsBody.contactTestBitMask = GMCollisionCategoryEnemy;
    
}

@end
