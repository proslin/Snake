//
//  SnakeHead.swift
//  snakeProsvetovaIOS
//
//  Created by Lina Prosvetova on 09.09.2022.
//
import UIKit
class SnakeHead: SnakeBodyPart {
    override init(atPoint point: CGPoint){
        super.init(atPoint:point)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}
