//
//  GMSpaceCatNode.h
//  Space Cat 5.1.1
//
//  Created by ED on 6/12/15.
//  Copyright (c) 2015 SwiftBeard. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GMSpaceCatNode : SKSpriteNode

+ (instancetype) spaceCatAtPosition:(CGPoint)position;
-(void)performTap;

@end
