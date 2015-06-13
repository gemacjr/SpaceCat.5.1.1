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
#import "GMSpaceDogNode.h"
#import "GMGroundNode.h"
#import "GMUtil.h"
#import <AVFoundation/AVFoundation.h>

@interface GMGamePlayScene ()

@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval timeSinceEnemyAdded;
@property (nonatomic) NSTimeInterval totalGameTime;
@property (nonatomic) NSInteger minSpeed;
@property (nonatomic) NSTimeInterval addEnemyTimeInterval;
@property (nonatomic) SKAction *damageSFX;
@property (nonatomic) SKAction *explodeSFX;
@property (nonatomic) SKAction *laserSFX;
@property (nonatomic) AVAudioPlayer *backgroundMusic;


@end

@implementation GMGamePlayScene


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        
        self.lastUpdateTimeInterval = 0;
        self.timeSinceEnemyAdded = 0;
        self.addEnemyTimeInterval = 1.5;
        self.totalGameTime = 0;
        self.minSpeed = GMSpaceDogMinSpeed;
        
        /* Setup your scene here */
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background_1"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        [self addChild:background];
        
        GMMachineNode *machine = [GMMachineNode machineAtPosition:CGPointMake(CGRectGetMidX(self.frame), 12)];
       
        [self addChild:machine];
        
        GMSpaceCatNode *spaceCat = [GMSpaceCatNode spaceCatAtPosition:CGPointMake(machine.position.x, machine.position.y-2)];
        
        [self addChild:spaceCat];
        
        
        
        self.physicsWorld.gravity = CGVectorMake(0, -9.8);
        self.physicsWorld.contactDelegate = self;
        
        GMGroundNode *ground = [GMGroundNode groundWithSize:CGSizeMake(self.frame.size.width, 22)];
        
        [self addChild:ground];
        
        [self setupSounds];
        
    }
    return self;
}

- (void) didMoveToView:(SKView *)view
{
    [self.backgroundMusic play];
}

- (void) setupSounds {
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Gameplay" withExtension:@"mp3"];
    self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    self.backgroundMusic.numberOfLoops = -1;
    [self.backgroundMusic prepareToPlay];
    
    self.damageSFX = [SKAction playSoundFileNamed:@"Damage.caf" waitForCompletion:NO];
    self.explodeSFX = [SKAction playSoundFileNamed:@"Explode.caf" waitForCompletion:NO];
    self.laserSFX = [SKAction playSoundFileNamed:@"Laser.caf" waitForCompletion:NO];
    
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
    
    [self runAction:self.laserSFX];
}


- (void) addSpaceDog {
    
    NSUInteger randomSpaceDog = [GMUtil randomWithMin:0 max:2];
    
    GMSpaceDogNode *spaceDog = [GMSpaceDogNode spaceDogType:randomSpaceDog];
    float dy = [GMUtil randomWithMin:GMSpaceDogMinSpeed max:GMSpaceDogMaxSpeed];
    spaceDog.physicsBody.velocity = CGVectorMake(0, dy);
    
    float y = self.frame.size.height + spaceDog.size.height;
    float x = [GMUtil randomWithMin:10+spaceDog.size.width max:self.frame.size.width-spaceDog.size.width-10];
    
    spaceDog.position = CGPointMake(x, y);
    
    [self addChild:spaceDog];
    
    
}

- (void)update:(NSTimeInterval)currentTime
{
    if (self.lastUpdateTimeInterval) {
        self.timeSinceEnemyAdded += currentTime - self.lastUpdateTimeInterval;
        self.totalGameTime += currentTime - self.lastUpdateTimeInterval;
    }
    
    if (self.timeSinceEnemyAdded > self.addEnemyTimeInterval) {
        [self addSpaceDog];
        self.timeSinceEnemyAdded = 0;
    }
    self.lastUpdateTimeInterval = currentTime;
    
    if (self.totalGameTime > 480 ) {
        //480 / 60 = 8 minutes
        self.addEnemyTimeInterval = 0.50;
        self.minSpeed = -160;
    } else if (self.totalGameTime > 240 ) {
        
        // 240 / 60 = 4 minutes
        
        self.addEnemyTimeInterval = 0.65;
        self.minSpeed = -150;
        
    } else if (self.totalGameTime > 120 ){
        self.addEnemyTimeInterval = 0.75;
        self.minSpeed = -125;
        
    } else if (self.totalGameTime > 30) {
        self.addEnemyTimeInterval = 1.00;
        self.minSpeed = -100;
        
    }
}

 - (void) didBeginContact:(SKPhysicsContact *)contact
{
    
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if (firstBody.categoryBitMask == GMCollisionCategoryEnemy && secondBody.categoryBitMask == GMCollisionCategoryProjectile) {
        
        
        GMSpaceDogNode *spaceDog = (GMSpaceDogNode *)firstBody.node;
        GMProjectileNode *projectile = (GMProjectileNode *)secondBody.node;
        
        if ([spaceDog isDamaged]) {
            [self runAction:self.explodeSFX];
            [spaceDog removeFromParent];
            [projectile removeFromParent];
            [self createDebrisAtPosition:contact.contactPoint];
        }
        
    } else if (firstBody.categoryBitMask == GMCollisionCategoryEnemy && secondBody.categoryBitMask == GMCollisionCategoryGround){
        [self runAction:self.damageSFX];
        GMSpaceDogNode *spaceDog = (GMSpaceDogNode *)firstBody.node;
        [spaceDog removeFromParent];
        [self createDebrisAtPosition:contact.contactPoint];
        
    }
    
    
}

- (void) createDebrisAtPosition:(CGPoint)position
{
    NSInteger numberOfPieces = [GMUtil randomWithMin:5 max:20];
    
    
    
    for (int i=0; i < numberOfPieces; i++) {
        NSInteger randomPiece = [GMUtil randomWithMin:1 max:4];
        NSString *imageName = [NSString stringWithFormat:@"debri_%ld", (long)randomPiece];
        
        SKSpriteNode *debris = [SKSpriteNode spriteNodeWithImageNamed:imageName];
        debris.position = position;
        [self addChild:debris];
        
        
        debris.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:debris.frame.size];
        debris.physicsBody.categoryBitMask = GMCollisionCategoryDebris;
        debris.physicsBody.contactTestBitMask = 0;
        debris.physicsBody.collisionBitMask = GMCollisionCategoryGround | GMCollisionCategoryDebris;
        debris.name = @"Debris";
        
        
        debris.physicsBody.velocity = CGVectorMake([GMUtil randomWithMin:-150 max:150], [GMUtil randomWithMin:150 max:350]);
        
        [debris runAction:[SKAction waitForDuration:2.0] completion:^{
            [debris removeFromParent];
        }];
    }
    
    NSString *explosionPath = [[NSBundle mainBundle] pathForResource:@"Explosion" ofType:@"sks"];
    SKEmitterNode *explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:explosionPath];
    
    explosion.position = position;
    [self addChild:explosion];
    
    [explosion runAction:[SKAction waitForDuration:2.0] completion:^{
        [explosion removeFromParent];
    }];
    
}
@end
