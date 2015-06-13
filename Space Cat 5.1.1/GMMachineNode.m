//
//  GMMachineNode.m
//  Space Cat 5.1.1
//
//  Created by ED on 6/12/15.
//  Copyright (c) 2015 SwiftBeard. All rights reserved.
//

#import "GMMachineNode.h"

@implementation GMMachineNode


+ (instancetype) machineAtPosition:(CGPoint)position
{
    GMMachineNode *machine = [self spriteNodeWithImageNamed:@"machine_1"];
    machine.position = position;
    machine.name = @"Machine";
    machine.anchorPoint = CGPointMake(0.5, 0);
    
    
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"machine_1"],
                          [SKTexture textureWithImageNamed:@"machine_2"]];
    
    
    SKAction *machineAnimation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    
    SKAction *machineRepeat = [SKAction repeatActionForever:machineAnimation];
    
    [machine runAction:machineRepeat];
    
    return machine;


}


@end
