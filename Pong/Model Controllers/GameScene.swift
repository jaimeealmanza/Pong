//
//  GameScene.swift
//  Pong
//
//  Created by Jaime Almanza on 22/02/18.
//  Copyright © 2018 Jaime Almanza. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // MARK: - Properties
    
    static let shared = GameScene()
    var pongBall = SKSpriteNode()
    var player1 = SKSpriteNode()
    var player2 = SKSpriteNode()
    var scores = [Int]()
    var player1Label = SKLabelNode()
    var player2Label = SKLabelNode()
    let pongBallEasyImpulseForPlayer1 = CGVector(dx: -6, dy: -6)
    let pongBallEasyImpulseForPlayer2 = CGVector(dx: 6, dy: 6)
    let pongBallMediumImpulseForPlayer1 = CGVector(dx: -8, dy: -8)
    let pongBallMediumImpulseForPlayer2 = CGVector(dx: 8, dy: 8)
    let pongBallHardImpulseForPlayer1 = CGVector(dx: -10, dy: -10)
    let pongBallHardImpulseForPlayer2 = CGVector(dx: 10, dy: 10)
    
    
    // MARK: - Lifecycle Functions
    
    override func didMove(to view: SKView) {
        pongBall = self.childNode(withName: "pongBall") as! SKSpriteNode
        player1 = self.childNode(withName: "player1") as! SKSpriteNode
        player1.position.y = (-self.frame.height / 2) + 50
        player2 = self.childNode(withName: "player2") as! SKSpriteNode
        player2.position.y = (self.frame.height / 2) - 50
        
        let screenBorder = SKPhysicsBody(edgeLoopFrom: self.frame)
        screenBorder.friction = 0
        screenBorder.restitution = 1
        self.physicsBody = screenBorder
        
        player1Label = self.childNode(withName: "player1Label") as! SKLabelNode
        player2Label = self.childNode(withName: "player2Label") as! SKLabelNode
        
        startGame()
    }
    
    
    // MARK: - Touching Functionality
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            if currentGameType == .twoPlayers {
                if touchLocation.y > 0 {
                    player2.run(SKAction.moveTo(x: touchLocation.x, duration: 0.1))
                }
                if touchLocation.y < 0 {
                    player1.run(SKAction.moveTo(x: touchLocation.x, duration: 0.1))
                }
            } else {
                player1.run(SKAction.moveTo(x: touchLocation.x, duration: 0.1))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            if currentGameType == .twoPlayers {
                if touchLocation.y > 0 {
                    player2.run(SKAction.moveTo(x: touchLocation.x, duration: 0.1))
                }
                if touchLocation.y < 0 {
                    player1.run(SKAction.moveTo(x: touchLocation.x, duration: 0.1))
                }
            } else {
                player1.run(SKAction.moveTo(x: touchLocation.x, duration: 0.1))
            }
        }
    }
    
    
    // MARK: - Functionality
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        switch currentGameType {
        case .easy: player2.run(SKAction.moveTo(x: pongBall.position.x, duration: 0.3))
        case .medium: player2.run(SKAction.moveTo(x: pongBall.position.x, duration: 0.22))
        case .hard: player2.run(SKAction.moveTo(x: pongBall.position.x, duration: 0.17))
        case .twoPlayers: break
        }
        if pongBall.position.y <= player1.position.y - 30 {
            addScore(to: player2)
        } else if pongBall.position.y >= player2.position.y + 30 {
            addScore(to: player1)
        }
    }
    
    
    // MARK: - Functions
    
    func startGame() {
        switch currentGameType {
        case .easy: pongBall.physicsBody?.applyImpulse(pongBallEasyImpulseForPlayer2)
        case .medium: pongBall.physicsBody?.applyImpulse(pongBallMediumImpulseForPlayer2)
        case .hard: pongBall.physicsBody?.applyImpulse(pongBallHardImpulseForPlayer2)
        case .twoPlayers: pongBall.physicsBody?.applyImpulse(pongBallHardImpulseForPlayer2)
        }
        scores = [0,0]
        setScoreLabels()
    }
    
    func addScore(to playerWhoWon: SKSpriteNode) {
        resetBall()
        if playerWhoWon == player1 {
            scores[0] += 1
            switch currentGameType {
            case .easy: pongBall.physicsBody?.applyImpulse(pongBallEasyImpulseForPlayer2)
            case .medium: pongBall.physicsBody?.applyImpulse(pongBallMediumImpulseForPlayer2)
            case .hard: pongBall.physicsBody?.applyImpulse(pongBallHardImpulseForPlayer2)
            case .twoPlayers: pongBall.physicsBody?.applyImpulse(pongBallHardImpulseForPlayer2)
            }
        } else if playerWhoWon == player2 {
            scores[1] += 1
            switch currentGameType {
            case .easy: pongBall.physicsBody?.applyImpulse(pongBallEasyImpulseForPlayer2)
            case .medium: pongBall.physicsBody?.applyImpulse(pongBallMediumImpulseForPlayer2)
            case .hard: pongBall.physicsBody?.applyImpulse(pongBallHardImpulseForPlayer2)
            case .twoPlayers: pongBall.physicsBody?.applyImpulse(pongBallHardImpulseForPlayer2)
            }
        }
        setScoreLabels()
    }
    
    func resetBall() {
        pongBall.position = CGPoint(x: 0, y: 0)
        pongBall.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
    }
    
    func setScoreLabels() {
        player1Label.text = "\(scores[0])"
        player2Label.text = "\(scores[1])"
        if scores[0] < scores[1] {
            player1Label.fontColor = .red
            player2Label.fontColor = .green
        } else if scores[1] < scores[0] {
            player2Label.fontColor = .red
            player1Label.fontColor = .green
        } else {
            player1Label.fontColor = .white
            player2Label.fontColor = .white
        }
    }
    
}
