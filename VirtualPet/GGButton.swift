//
//  GGButton.swift
//  VirtualPet
//
//  Created by Kiv Celik on 07/12/2015.
//  Copyright © 2015 Kiv Celik. All rights reserved.
//

import SpriteKit

class GGButton: SKNode {
    var defaultButton: SKSpriteNode
    var activeButton: SKSpriteNode
    var action: () -> Void
    
    init(defaultButtonImage: String, activeButtonImage: String, buttonAction: () -> Void) {
        defaultButton = SKSpriteNode(imageNamed: defaultButtonImage)
        activeButton = SKSpriteNode(imageNamed: activeButtonImage)
        activeButton.hidden = true
        action = buttonAction
        
        super.init()
        
        userInteractionEnabled = true
        addChild(defaultButton)
        addChild(activeButton)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        activeButton.hidden = false
        defaultButton.hidden = true
    }
    
    /**
     Required so XCode doesn't throw warnings
     */
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
  