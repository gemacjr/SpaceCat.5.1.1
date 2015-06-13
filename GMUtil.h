//
//  GMUtil.h
//  Space Cat 5.1.1
//
//  Created by ED on 6/12/15.
//  Copyright (c) 2015 SwiftBeard. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int GMProjectileSpeed = 300;

typedef NS_OPTIONS(uint32_t, GMCollisionCategory) {
    GMCollisionCategoryEnemy        = 1 << 0,       // 0000
    GMCollisionCategoryProjectile   = 1 << 1,       // 0010
    GMCollisionCategoryDebris       = 1 << 2,       // 0100
    GMCollisionCategoryGround       = 1 << 3        // 1000
};

@interface GMUtil : NSObject


+ (NSInteger) randomWithMin:(NSInteger)min max:(NSInteger)max;
@end
