//
//  GameViewController.swift
//  SideScroller
//
//  Created by Justin Dike 2 on 10/20/15.
//  Copyright (c) 2015 CartoonSmart. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation
class GameViewController: UIViewController {
    
    var bgSoundPlayer:AVAudioPlayer?
    var bgSoundVolume:Float = 0.25 // 0.5 would be 50% or half volume
    var bgSoundLoops:Int = -1 // -1 will loop it forever
    var bgSoundContinues:Bool = false
    
    let defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.playBackgroundSound(_:)), name: "PlayBackgroundSound", object: nil)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.stopBackgroundSound), name: "StopBackgroundSound", object: nil)
        
        
        let sks:String = "Home" // This value will be used to find a matching SKS file, for example, "Home.sks"  then  within the class it will be used as the name of the dictionary to look up in the property list. 

        if let scene = Home(fileNamed: sks) {
            
            
            scene.propertyListData = sks
            
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            
            skView.showsPhysics = false
            
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            
            
            skView.presentScene(scene)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    func playBackgroundSound(notification: NSNotification) {
        
        
        let name = notification.userInfo!["fileToPlay"] as! String
        
    
        
        if (bgSoundPlayer != nil){
            
            bgSoundPlayer!.stop()
            bgSoundPlayer = nil
            
            
        }
        
        if (name != ""){
        
        let fileURL:NSURL = NSBundle.mainBundle().URLForResource(name, withExtension: "mp3")!
        
        do {
            bgSoundPlayer = try AVAudioPlayer(contentsOfURL: fileURL)
        } catch _{
            bgSoundPlayer = nil
            
        }
        
        bgSoundPlayer!.volume = 0.25
        bgSoundPlayer!.numberOfLoops = -1
        bgSoundPlayer!.prepareToPlay()
        bgSoundPlayer!.play()
            
        }
        
        
    }
    func stopBackgroundSound() {
        
        if (bgSoundPlayer != nil){
            
            bgSoundPlayer!.stop()
            bgSoundPlayer = nil
            
            
        }
        
    }
    
    
}
