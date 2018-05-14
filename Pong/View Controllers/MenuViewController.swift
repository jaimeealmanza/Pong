//
//  MenuViewController.swift
//  Pong
//
//  Created by Jaime Almanza on 22/02/18.
//  Copyright © 2018 Jaime Almanza. All rights reserved.
//

import UIKit

enum GameType {
    case easy
    case medium
    case hard
    case twoPlayers
}

class MenuViewController: UIViewController {
    
    
    // MARK: - Outlets and Actions
    
    @IBAction func easyButtonTapped(_ sender: UIButton) {
        moveToGame(ofType: .easy)
    }
    @IBAction func mediumButtonTapped(_ sender: UIButton) {
        moveToGame(ofType: .medium)
    }
    @IBAction func hardButtonTapped(_ sender: UIButton) {
        moveToGame(ofType: .hard)
    }
    @IBAction func twoPlayersButtonTapped(_ sender: UIButton) {
        moveToGame(ofType: .twoPlayers)
    }
    
    
    // MARK: - Properties
    
    

    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Functions
    
    func moveToGame(ofType: GameType) {
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        currentGameType = ofType
        self.navigationController?.pushViewController(gameVC, animated: true)
    }

}
