//
//  Portal.swift
//  SideScroller
//
//  Created by Justin Dike 2 on 10/21/15.
//  Copyright © 2015 CartoonSmart. All rights reserved.
//

import Foundation
import SpriteKit


class Ammo: SKSpriteNode {
    
    var initialPosition:CGPoint = CGPointZero
    var canAward:Bool = true
    var awardsHowMuch:Int = 10
    var spawnsHowOften:UInt32 = 30
    var spawnsAtRandomTime:Bool = false
    var minimumTimeBetweenSpawns:NSTimeInterval = 5
    var awardsToBothPlayers:Bool = false
    var onlyAllowOneAtATime:Bool = false
    var soundAmmoCollect:String = ""
    var soundAmmoDrop:String = ""
    
   
    
    func setUp() {
        
        self.alpha = 0
        canAward = false
        
        initialPosition = self.position
        

        self.physicsBody?.categoryBitMask = BodyType.ammo.rawValue
        self.physicsBody?.collisionBitMask = BodyType.platform.rawValue | BodyType.deadZone.rawValue | BodyType.player.rawValue
        self.physicsBody?.contactTestBitMask = BodyType.player.rawValue
        
        
        self.physicsBody?.dynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        
        
        drop()
        
    }
    
    func pickedUp() {
        
        
        playSound(soundAmmoCollect)
        
        
        
        canAward = false
        
        self.physicsBody?.dynamic = false
        self.physicsBody?.affectedByGravity = false
        
        
        
        self.alpha = 0
        
        
        waitToDrop()
        
        if ( onlyAllowOneAtATime == true ) {
            
            if let scene:GameScene = self.parent as? GameScene {
                
                if ( self.name == "Player1Ammo") {
                    
                    scene.hasPlayer1AmmoAlready = false
                }
                if ( self.name == "Player2Ammo") {
                    
                    scene.hasPlayer2AmmoAlready = false
                }
            }
            
        }
        
                        
                      
        
        
    }
    
    func waitToDrop(){
        
        var refreshRandom:UInt32 = 0
        
        var refreshTime:NSTimeInterval = 0
        
        if ( spawnsAtRandomTime == true ) {
            
            refreshRandom = arc4random_uniform(spawnsHowOften)
            
            refreshTime = NSTimeInterval(refreshRandom) + minimumTimeBetweenSpawns
            
        } else {
            
            refreshTime = NSTimeInterval(spawnsHowOften) + minimumTimeBetweenSpawns
            
        }
        
        
        
        
        
        let move:SKAction = SKAction.moveTo(initialPosition, duration: 0)
        self.runAction(move)
        
        
        let wait:SKAction = SKAction.waitForDuration(refreshTime)
        let run:SKAction = SKAction.runBlock{
            
            self.drop()
        }
        
        let seq:SKAction = SKAction.sequence( [wait, run ])
        self.runAction(seq)
    }
    
    
    func drop() {
        
        
         if ( onlyAllowOneAtATime == true ) {
        
            if let scene:GameScene = self.parent as? GameScene {
            
 
                if ( self.name == "Player1Ammo") {
            
                    if (scene.hasPlayer1AmmoAlready == true){
                
                        waitToDrop()
                
                    } else {
                
                        scene.hasPlayer1AmmoAlready = true
                        canAward = true
                
                        self.alpha = 1
                        self.physicsBody?.dynamic = true
                        self.physicsBody?.affectedByGravity = true
                        self.physicsBody?.allowsRotation = true
                        
                         playSound(soundAmmoDrop)
                
                    }
            
                } else if ( self.name == "Player2Ammo") {
                    
                    if (scene.hasPlayer2AmmoAlready == true){
                        
                        waitToDrop()
                        
                    } else {
                        
                        scene.hasPlayer2AmmoAlready = true
                        canAward = true
                        
                        self.alpha = 1
                        self.physicsBody?.dynamic = true
                        self.physicsBody?.affectedByGravity = true
                        self.physicsBody?.allowsRotation = true
                        
                        playSound(soundAmmoDrop)
                        
                    }
                    
                }
                
            }
            
            
            
         } else {
            
            
            canAward = true
            
            self.alpha = 1
            self.physicsBody?.dynamic = true
            self.physicsBody?.affectedByGravity = true
            self.physicsBody?.allowsRotation = true
            
        }
        
        
        
        
        
    }
    
    func playSound(theSound:String ){
        
        if (theSound != ""){
        
            let sound:SKAction = SKAction.playSoundFileNamed(theSound, waitForCompletion: true)
            self.runAction(sound)
            
        }
        
    }
    
    
}