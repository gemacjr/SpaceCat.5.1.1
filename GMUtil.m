//
//  GMUtil.m
//  Space Cat 5.1.1
//
//  Created by ED on 6/12/15.
//  Copyright (c) 2015 SwiftBeard. All rights reserved.
//

#import "GMUtil.h"

@implementation GMUtil

+ (NSInteger) randomWithMin:(NSInteger)min max:(NSInteger)max
{
    
    
    return arc4random()%(max - min) + min;
}


@end
