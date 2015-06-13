//
//  GMGamePlayScene.m
//  Space Cat 5.1.1
//
//  Created by ED on 6/12/15.
//  Copyright (c) 2015 SwiftBeard. All rights reserved.
//

#import "GMGamePlayScene.h"
#import "GMMachineNode.h"
#import "GMSpaceCatNode.h"
#import "GMProjectileNode.h"

@implementation GMGamePlayScene


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background_1"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        [self addChild:background];
        
        GMMachineNode *machine = [GMMachineNode machineAtPosition:CGPointMake(CGRectGetMidX(self.frame), 12)];
       
        [self addChild:machine];
        
        GMSpaceCatNode *spaceCat = [GMSpaceCatNode spaceCatAtPosition:CGPointMake(machine.position.x, machine.position.y-2)];
        
        [self addChild:spaceCat];
        
    }
    return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        CGPoint position = [touch locationInNode:self];
        
        [self shootProjectileTowardsPosition:position];
    }
}

-(void) shootProjectileTowardsPosition:(CGPoint)position
{
    GMSpaceCatNode *spaceCat = (GMSpaceCatNode*)[self childNodeWithName:@"SpaceCat"];
    [spaceCat performTap];
    
    GMMachineNode *machine = (GMMachineNode *)[self childNodeWithName:@"Machine"];
    
    GMProjectileNode *projectile = [GMProjectileNode projectAtPosition:CGPointMake(machine.position.x, machine.position.y + machine.frame.size.height - 15)];
    [self addChild:projectile];
    [projectile moveTowardsPosition:position];
}


@end
