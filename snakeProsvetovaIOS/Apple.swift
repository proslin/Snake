//
//  Apple.swift
//  snakeProsvetovaIOS
//
//  Created by Lina Prosvetova on 09.09.2022.
//
import UIKit
import SpriteKit// Яблоко
class Apple: SKShapeNode { //определяем, каконобудетотрисовываться
    convenience init(position: CGPoint) {
        self.init()
        // рисуемкруг
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        // заливаемкрасным
        fillColor = UIColor.red
        // рамкатожекрасная
        strokeColor = UIColor.red
        // ширинарамки 5 поинтов
        lineWidth = 5
        self.position = position
        
    }
}