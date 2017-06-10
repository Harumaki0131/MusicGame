//
//  SpritePlayScene.swift
//  Musicgame
//
//  Created by EriyaMurakami on 2017/06/10.
//  Copyright © 2017年 EriyaMurakami. All rights reserved.
//

import Foundation

//
//  2ViewController.swift
//  Musicgame
//
//  Created by EriyaMurakami on 2016/08/04.
//  Copyright © 2016年 EriyaMurakami. All rights reserved.
//

import UIKit
import SpriteKit


class SpritePlayScene: SKScene, SKPhysicsContactDelegate {
    
    var nodeSize:CGFloat = 0.0
    
    var timer:NSTimer!
    
    var isNodeStop = false
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        //ここで呼び出す
        //ヒント
        let saveDate: NSUserDefaults = NSUserDefaults.standardUserDefaults()
//        saveDate.setObject(timingArray, forKey: "timing" )
          saveData.object(forKey: "timing")

        
        self.view?.backgroundColor = UIColor.clearColor()
        self.physicsWorld.contactDelegate = self
        //        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 1.0)
        
        
        
        
        nodeSize = view.frame.width / 20//................................
        //.
        for i in 0..<8{                                                //.
            //.
        }                                                              //.
        //.
        var node:SKSpriteNode = SKSpriteNode()                         //.
        node.color = UIColor.blueColor()//(色）                         //.
        node.position = view.center//（生成位置）                        //.
        node.size = CGSize(width: nodeSize, height: nodeSize)//(サイズ）//.
        node.physicsBody = SKPhysicsBody(circleOfRadius: nodeSize/2)
        node.physicsBody?.contactTestBitMask = 0x1 << UInt32(1)
        node.physicsBody?.allowsRotation = false
        node.physicsBody?.restitution = 0.0
        node.physicsBody?.affectedByGravity = false
        node.name = ""
        
        addChild(node)
        
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "timerUpDate:", userInfo: nil, repeats: true)
        
    }
    
    override func update(currentTime: NSTimeInterval) {
        super.update(currentTime)
        
        
        
        
    }
    
    func timerUpDate(timer:NSTimer){
        
        isNodeStop = false
        
        
        
    }
    
    func showNode(){
        
        if isNodeStop == false{
            var node:SKSpriteNode = SKSpriteNode()
            node.color = UIColor.blueColor()
            node.position = self.view!.center
            node.size = CGSize(width: nodeSize, height: nodeSize)
            node.physicsBody = SKPhysicsBody(circleOfRadius: nodeSize/2)
            node.physicsBody?.contactTestBitMask = 0x1 << UInt32(1)
            node.physicsBody?.allowsRotation = false
            node.physicsBody?.restitution = 0.0
            node.physicsBody?.affectedByGravity = false
            node.name = "test"
            addChild(node)
            
            //            let action = SKAction.move(to: , duration: 1.0)
            
            var houkou:UInt32 = 8
            
            let random = Int(arc4random_uniform(houkou))
            var kakudo:Double!
            
            kakudo = Double(random) * 2 * M_PI / Double(houkou)
            
            
            let action = SKAction.moveTo(CGPoint(x: self.view!.center.x + CGFloat(400 * cos(kakudo)), y: self.view!.center.y + CGFloat(400*sin(kakudo))), duration: 1.5)
            node.runAction(action)
            
            
            isNodeStop = true
        }
        
        
        
    }
    
}

