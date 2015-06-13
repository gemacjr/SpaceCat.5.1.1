//
//  GMHudNode.h
//  Space Cat 5.1.1
//
//  Created by ED on 6/13/15.
//  Copyright (c) 2015 SwiftBeard. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GMHudNode : SKNode

@property (nonatomic) NSInteger lives;
@property (nonatomic) NSInteger score;

+ (instancetype) hudAtPosition:(CGPoint)position;

@end
