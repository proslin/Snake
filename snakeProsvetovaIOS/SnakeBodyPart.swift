//
//  SnakeBodyPart.swift
//  snakeProsvetovaIOS
//
//  Created by Lina Prosvetova on 09.09.2022.
//
import UIKit
import SpriteKit
class SnakeBodyPart: SKShapeNode {
    let diameter = 10.0// добавляемконструктор
    init (atPoint point: CGPoint){
        super.init()
        //рисуем круглый элемент
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: CGFloat(diameter), height: CGFloat(diameter))).cgPath
        // цветрамкиизаливкизеленый
        fillColor = UIColor.green
        strokeColor = UIColor.green
        // ширинарамки 5 поинтов
        lineWidth = 5// размещаемэлементвпереданнойточке
        self.position = point
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}

}
