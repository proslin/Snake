//
//  GameViewController.swift
//  snakeProsvetovaIOS
//
//  Created by Lina Prosvetova on 09.09.2022.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size: view.bounds.size)// получаемглавнуюобластьэкрана
        let skView = view as! SKView
        // включаемотображение fps (количествокадроввсекунду)
            skView.showsFPS = true
        // показыватьколичествообъектовнаэкране
            skView.showsNodeCount = true
        // включаемпроизвольныйпорядокрендерингаобъектоввузле
            skView.ignoresSiblingOrder = true
        // режимотображениясцены, растягиваетсянавседоступноепространство
            scene.scaleMode = .resizeFill
        // добавляемсценунаэкран
         skView.presentScene(scene)
        
    }
        

    
}
