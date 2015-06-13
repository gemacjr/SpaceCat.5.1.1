//
//  GMProjectileNode.h
//  Space Cat 5.1.1
//
//  Created by ED on 6/12/15.
//  Copyright (c) 2015 SwiftBeard. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GMProjectileNode : SKSpriteNode

+ (instancetype) projectAtPosition:(CGPoint)position;
- (void) moveTowardsPosition:(CGPoint)position;

@end
