//
//  GameScene.swift
//  TouchGame
//
//  Created by Diana Smetters on 3/22/15.
//  Copyright (c) 2015 Diana Smetters. All rights reserved.
//

import SpriteKit

// Enumeration -- defines a variable class with five different values
enum TouchCommand {
    case MOVE_UP,
    MOVE_DOWN,
    MOVE_LEFT,
    MOVE_RIGHT,
    NO_COMMAND
}
class GameScene: SKScene {
    let Y_DELTA:CGFloat = 30
    let X_DELTA:CGFloat = 30
    let NAV_FRACTION:CGFloat = 0.25

    /* Properties */
    let character = SKSpriteNode(imageNamed: "Spaceship")  // use Spaceship.png file for the image of the sprite

    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = UIColor(red:0.15, green:0.15, blue:0.3, alpha:1.0)
        character.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        character.setScale(0.10)
        self.addChild(character)   // Make sprite visible
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        for touch in touches {
            let command: TouchCommand = commandForTouch(touch as UITouch, node:self)
            let moveDistance = 30

            var move_x:CGFloat = 0
            var move_y:CGFloat = 0

            // Here is where you need to insert you code to set how much
            // to move in the x direction (left / right) or the y direction (up / down)
            if (command == TouchCommand.MOVE_UP) {
                move_y = Y_DELTA
            } else if (command == TouchCommand.MOVE_DOWN) {
                move_y = -1 * Y_DELTA
            } else if (command == TouchCommand.MOVE_LEFT) {
                move_x = -1 * X_DELTA
            } else if (command == TouchCommand.MOVE_RIGHT) {
                move_x = X_DELTA
            }
            
            if (move_x != 0 || move_y != 0) {
                let action:SKAction = SKAction.moveByX(move_x, y: move_y, duration: 0.25)
                self.character.runAction(action)
            }
        }
        println("Position: \(self.character.position)")
    }
   
    // Figures out which way the user wants to move the character based on which
    // edge of the screen the user touched.
    func commandForTouch(touch:UITouch, node:SKNode) -> TouchCommand {
        let location:CGPoint = touch.locationInNode(node)
        let frame:CGRect = node.frame
        let height = CGRectGetHeight(frame)
        let width = CGRectGetWidth(frame)

        if (location.y/height < NAV_FRACTION) {
            return TouchCommand.MOVE_DOWN
        }
        if (location.y/height > (1 - NAV_FRACTION)) {
            return TouchCommand.MOVE_UP
        }
        else if (location.x/width < NAV_FRACTION) {
            return TouchCommand.MOVE_LEFT
        }
        else if (location.x/width > (1 - NAV_FRACTION)) {
            return TouchCommand.MOVE_RIGHT
        }
        return TouchCommand.NO_COMMAND
    }

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
 }
