//
//  GMSpaceDogNode.h
//  Space Cat 5.1.1
//
//  Created by ED on 6/12/15.
//  Copyright (c) 2015 SwiftBeard. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSUInteger, GMSpaceDogType) {
    GMSpaceDogTypeA = 0,
    GMSpaceDogTypeB = 1
    
};

@interface GMSpaceDogNode : SKSpriteNode

+ (instancetype) spaceDogType:(GMSpaceDogType)type;


@end
