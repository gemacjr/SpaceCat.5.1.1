//
//  GMSpaceCatNode.m
//  Space Cat 5.1.1
//
//  Created by ED on 6/12/15.
//  Copyright (c) 2015 SwiftBeard. All rights reserved.
//

#import "GMSpaceCatNode.h"

@interface GMSpaceCatNode ()

@property (nonatomic) SKAction *tapAction;

@end

@implementation GMSpaceCatNode


+ (instancetype) spaceCatAtPosition:(CGPoint)position
{
    
    GMSpaceCatNode *spaceCat = [self spriteNodeWithImageNamed:@"spacecat_1"];
    spaceCat.position = position;
    spaceCat.anchorPoint = CGPointMake(0.5, 0);
    spaceCat.name = @"SpaceCat";
    
    
    return spaceCat;
}

- (void) performTap {
    [self runAction:self.tapAction];
}


- (SKAction *) tapAction {
    
    if (_tapAction != nil){
        return _tapAction;
    }
    
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"spacecat_2"],
                          [SKTexture textureWithImageNamed:@"spacecat_1"]];
    
    _tapAction = [SKAction animateWithTextures:textures timePerFrame:0.25];
    
    return _tapAction;
}


@end
