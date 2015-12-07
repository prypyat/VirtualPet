//
//  GameScene.swift
//  VirtualPet
//
//  Created by Kiv Celik on 06/12/2015.
//  Copyright (c) 2015 Kiv Celik. All rights reserved.
//

import UIKit
import SpriteKit

class GameScene: SKScene
{
    var state: String = "Idle"
    
    var sleepiness: Float = 100
    var hunger: Float = 100
    var health: Float = 100
    var fun: Float = 100
    var age: Float = 0
    
    var sleepAct: Float = 0
    var hungerAct: Float = 0
    var healthAct: Float = 0
    var funAct: Float = 0
    
    var great = SKSpriteNode(imageNamed: "great")
    var good = SKSpriteNode(imageNamed: "good")
    var okay = SKSpriteNode(imageNamed: "okay")
    var bad = SKSpriteNode(imageNamed: "bad")
    
    var eatface = SKSpriteNode(imageNamed: "eat")
    var funface = SKSpriteNode(imageNamed: "fun")
    var sleepface = SKSpriteNode(imageNamed: "sleep")
    var healthface = SKSpriteNode(imageNamed: "health")
    
    var play = SKSpriteNode(imageNamed: "play")
    var clean = SKSpriteNode(imageNamed: "clean")
    var eatbutton = SKSpriteNode(imageNamed: "eatbutton")
    var sleepbutton = SKSpriteNode(imageNamed: "sleepbutton")
    
    var playIcon = SKSpriteNode(imageNamed: "play")
    var cleanIcon = SKSpriteNode(imageNamed: "clean")
    var eatbuttonIcon = SKSpriteNode(imageNamed: "eatbutton")
    var sleepbuttonIcon = SKSpriteNode(imageNamed: "sleepbutton")
    
    var sleepLabel = SKLabelNode(fontNamed: "TrebuchetMS-Bold")
    var hungerLabel = SKLabelNode(fontNamed: "TrebuchetMS-Bold")
    var healthLabel = SKLabelNode(fontNamed: "TrebuchetMS-Bold")
    var funLabel = SKLabelNode(fontNamed: "TrebuchetMS-Bold")
    var ageLabel = SKLabelNode(fontNamed: "TrebuchetMS-Bold")
    
    var ripip = SKSpriteNode(imageNamed: "rip")

    
    override func didMoveToView(view: SKView)
    {
        backgroundColor = SKColor.whiteColor()
        
        createPet()
        
        createButtons()
        
        createIcons()
        
        createMeters()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
       
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        guard let touch = touches.first else
        {
            return
        }
        let touchLocation = touch.locationInNode(self)
        
        if (state == "Dead")
        {
            sleepiness  = 100
            hunger  = 100
            health  = 100
            fun  = 100
            age  = 0
            
            state = "Idle"
            
            sleepAct = 0
            hungerAct = 0
            healthAct = 0
            funAct = 0
            
            healthface.hidden = false
            eatface.hidden = true
            sleepface.hidden = true
            funface.hidden = true
            ripip.hidden = true
            healthface.hidden = true
            eatface.hidden = true
            sleepface.hidden = true
            funface.hidden = true
            
            createButtons()
            createMeters()
            createIcons()
            

        }
        
        if (state != "Idle" && state != "Dead")
        {
            state = "Idle"
            
            sleepAct = 0
            hungerAct = 0
            healthAct = 0
            funAct = 0
            
            healthface.hidden = true
            eatface.hidden = true
            sleepface.hidden = true
            funface.hidden = true
            
            createButtons()
        }
        
        if (play.containsPoint(touchLocation) && state == "Idle")
        {
            state = "Play"
           
            sleepAct = -1
            hungerAct = -1
            healthAct = 0
            funAct = 5
            
            great.hidden = true
            good.hidden = true
            okay.hidden = true
            bad.hidden = true
            healthface.hidden = true
            eatface.hidden = true
            sleepface.hidden = true
            funface.hidden = false
            
            destroyButtons()
        }
        
        if (eatbutton.containsPoint(touchLocation) && state == "Idle")
        {
            state = "Eat"
            
            sleepAct = 0
            hungerAct = 5
            healthAct = -1
            funAct = 0
            
            great.hidden = true
            good.hidden = true
            okay.hidden = true
            bad.hidden = true
            healthface.hidden = true
            eatface.hidden = false
            sleepface.hidden = true
            funface.hidden = true
            
            destroyButtons()
        }

        if (clean.containsPoint(touchLocation) && state == "Idle")
        {
            state = "Clean"
            
            sleepAct = 0
            hungerAct = 0
            healthAct = 5
            funAct = -1
            
            great.hidden = true
            good.hidden = true
            okay.hidden = true
            bad.hidden = true
            healthface.hidden = false
            eatface.hidden = true
            sleepface.hidden = true
            funface.hidden = true
            
            destroyButtons()
        }

        if (sleepbutton.containsPoint(touchLocation) && state == "Idle")
        {
            state = "Sleep"
            
            sleepAct = 5
            hungerAct = 0
            healthAct = 0
            funAct = 0
            
            great.hidden = true
            good.hidden = true
            okay.hidden = true
            bad.hidden = true
            healthface.hidden = true
            eatface.hidden = true
            sleepface.hidden = false
            funface.hidden = true
            
            destroyButtons()
        }

    }
   
    override func update(currentTime: CFTimeInterval)
    {
        sleepiness = sleepiness + ((SleepDecay + sleepAct)/100)*TimeScale
        hunger = hunger + ((FoodDecay + hungerAct)/100)*TimeScale
        health = health + ((HealthDecay + healthAct)/100)*TimeScale
        fun = fun + ((FunDecay + funAct)/100)*TimeScale
        
        if sleepiness > 100 {sleepiness = 100}
        if hunger > 100 {hunger = 100}
        if health > 100 {health = 100}
        if fun > 100 {fun = 100}
        
        if sleepiness < 00 {sleepiness = 00}
        if hunger < 00 {hunger = 00}
        if health < 00 {health = 00}
        if fun < 00 {fun = 00}
        
        sleepLabel.text = String(format: "%.2f", sleepiness)
        hungerLabel.text = String(format: "%.2f", hunger)
        healthLabel.text = String(format: "%.2f", health)
        funLabel.text = String(format: "%.2f", fun)
        ageLabel.text = String(format: "%.2f", age)
        
        
        if (sleepiness > 75 && hunger > 75 && health > 75 && fun > 75 && state == "Idle")
        {
            great.hidden = false
            good.hidden = true
            okay.hidden = true
            bad.hidden = true
        }
        
        if ((sleepiness < 75 || hunger < 75 || health < 75 || fun < 75) && state == "Idle")
        {
            great.hidden = true
            good.hidden = false
            okay.hidden = true
            bad.hidden = true
        }
        
        if ((sleepiness < 50 || hunger < 50 || health < 50 || fun < 50) && state == "Idle")
        {
            great.hidden = true
            good.hidden = true
            okay.hidden = false
            bad.hidden = true
        }
        
        if ((sleepiness < 25 || hunger < 25 || health < 25 || fun < 25) && state == "Idle")
        {
            great.hidden = true
            good.hidden = true
            okay.hidden = true
            bad.hidden = false
        }
        
        if (sleepiness == 0 || hunger == 0 || health == 0 || fun == 0)
        {
            destroyButtons()
            destroyIcons()
            destroyMeters()
            
            great.hidden = true
            good.hidden = true
            okay.hidden = true
            bad.hidden = true
            healthface.hidden = true
            eatface.hidden = true
            sleepface.hidden = true
            funface.hidden = true
            ripip.hidden = false
            
            state = "Dead"
        }
    }
    
    func createButtons()
    {
        play.position = CGPoint(x: size.width/5*1.75, y: size.height/6.5)
        play.name = "playButton"
        play.setScale(0.5)
        addChild(play)
        
        clean.position = CGPoint(x: size.width/5*2.25, y: size.height/6.5)
        clean.name = "cleanButton"
        clean.setScale(0.5)
        addChild(clean)
        
        eatbutton.position = CGPoint(x: size.width/5*2.75, y: size.height/6.5)
        eatbutton.name = "eatButton"
        eatbutton.setScale(0.5)
        addChild(eatbutton)
        
        sleepbutton.position = CGPoint(x: size.width/5*3.25, y: size.height/6.5)
        sleepbutton.name = "sleepButton"
        sleepbutton.setScale(0.5)
        addChild(sleepbutton)
    }
    
    func destroyButtons()
    {
        play.removeFromParent()
        clean.removeFromParent()
        eatbutton.removeFromParent()
        sleepbutton.removeFromParent()
    }
    
    func createIcons()
    {
        playIcon.position = CGPoint(x: size.width/5*1.75, y: size.height/1.1)
        playIcon.setScale(0.25)
        addChild(playIcon)
        
        cleanIcon.position = CGPoint(x: size.width/5*1.75, y: size.height/1.3)
        cleanIcon.setScale(0.25)
        addChild(cleanIcon)
        
        eatbuttonIcon.position = CGPoint(x: size.width/5*3.25, y: size.height/1.1)
        eatbuttonIcon.setScale(0.25)
        addChild(eatbuttonIcon)
        
        sleepbuttonIcon.position = CGPoint(x: size.width/5*3.25, y: size.height/1.3)
        sleepbuttonIcon.setScale(0.25)
        addChild(sleepbuttonIcon)
    }
    
    func destroyIcons()
    {
        playIcon.removeFromParent()
        cleanIcon.removeFromParent()
        eatbuttonIcon.removeFromParent()
        sleepbuttonIcon.removeFromParent()
    }
    
    func createMeters()
    {
        sleepLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        sleepLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Top
        sleepLabel.position = CGPoint(x: size.width/5*2.7, y: size.height/1.275)
        sleepLabel.fontColor = SKColor(red: 156/255.0, green: 179/255.0, blue: 207/255.0, alpha: 1.0)
        sleepLabel.fontSize = 30
        addChild(sleepLabel)
        
        hungerLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        hungerLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Top
        hungerLabel.position = CGPoint(x: size.width/5*2.7, y: size.height/1.075)
        hungerLabel.fontColor = SKColor(red: 156/255.0, green: 179/255.0, blue: 207/255.0, alpha: 1.0)
        hungerLabel.fontSize = 30
        addChild(hungerLabel)
        
        healthLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
        healthLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Top
        healthLabel.position = CGPoint(x: size.width/5*2.3, y: size.height/1.275)
        healthLabel.fontColor = SKColor(red: 156/255.0, green: 179/255.0, blue: 207/255.0, alpha: 1.0)
        healthLabel.fontSize = 30
        addChild(healthLabel)
        
        funLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
        funLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Top
        funLabel.position = CGPoint(x: size.width/5*2.3, y: size.height/1.075)
        funLabel.fontColor = SKColor(red: 156/255.0, green: 179/255.0, blue: 207/255.0, alpha: 1.0)
        funLabel.fontSize = 30
        addChild(funLabel)
    }
    
    func destroyMeters()
    {
        sleepLabel.removeFromParent()
        hungerLabel.removeFromParent()
        healthLabel.removeFromParent()
        funLabel.removeFromParent()
    }
    
    func createPet()
    {
        great.position = CGPoint(x: size.width/2, y: size.height/2)
        good.position = CGPoint(x: size.width/2, y: size.height/2)
        okay.position = CGPoint(x: size.width/2, y: size.height/2)
        bad.position = CGPoint(x: size.width/2, y: size.height/2)
        eatface.position = CGPoint(x: size.width/2, y: size.height/2)
        sleepface.position = CGPoint(x: size.width/2, y: size.height/2)
        funface.position = CGPoint(x: size.width/2, y: size.height/2)
        healthface.position = CGPoint(x: size.width/2, y: size.height/2)
        ripip.position = CGPoint(x: size.width/2, y: size.height/2)


        addChild(great)
        addChild(good)
        addChild(okay)
        addChild(bad)
        addChild(eatface)
        addChild(sleepface)
        addChild(funface)
        addChild(healthface)
        addChild(ripip)

        
        great.hidden = false
        good.hidden = true
        okay.hidden = true
        bad.hidden = true
        healthface.hidden = true
        eatface.hidden = true
        sleepface.hidden = true
        funface.hidden = true
        ripip.hidden = true
    }
    
}




















