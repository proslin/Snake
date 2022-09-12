//
//  Snake.swift
//  snakeProsvetovaIOS
//
//  Created by Lina Prosvetova on 09.09.2022.
//

import UIKit
import SpriteKit
// самазмейка
class Snake: SKShapeNode {
    // скоростьперемещения
    let moveSpeed = 125.0
    // угол, необходимыйдлярасчетанаправления
    var angle: CGFloat = 0.0
    // массив, гдехранятсясегментытела
    var body = [SnakeBodyPart]()
    
    // конструктор
    convenience init(atPoint point: CGPoint) {
        self.init()
        // змейканачинаетсясголовы, создадимее
        let head = SnakeHead(atPoint: point)
        // и добавим в массив
        body.append(head)
        // исделаемеедочернимобъектом.
        addChild(head)
        
    }
    
    // методдобавляетещеодинсегменттела
    func addBodyPart(){
        // инстанцируемсегмент
        let newBodyPart = SnakeBodyPart(atPoint: CGPoint(x: body[0].position.x, y: body[0].position.y))
        // добавляемеговмассив
        body.append(newBodyPart)
        // делаемдочернимобъектом
        addChild(newBodyPart)
    }
    
    //перемещаемзмейку
    func move(){
        // еслиузмейкинетголовы, ничегонеперемещаем
        guard !body.isEmpty else { return }
        // перемещаемголову
        let head = body[0]
        moveHead(head)
        // перемещаемвсесегментытела
        for index in (0..<body.count) where index > 0 {
            let previousBodyPart = body[index-1]
            let currentBodyPart = body[index]
            moveBodyPart(previousBodyPart, c: currentBodyPart)
            
        }
    }
        
        //перемещаемголову
        func moveHead(_ head: SnakeBodyPart){
            // рассчитываемсмещениеточки
            let dx = CGFloat(moveSpeed) * sin(angle);
            let dy = CGFloat(moveSpeed) * cos(angle);
            // смещаемточкуназначенияголовы
            let nextPosition = CGPoint(x: head.position.x + dx, y: head.position.y + dy)
            // действиеперемещенияголовы
            let moveAction = SKAction.move(to: nextPosition, duration: 1.0)
            // запускдействияперемещения
            head.run(moveAction)
            
        }
        // перемещаемсегментзмеи
        func moveBodyPart(_ p: SnakeBodyPart, c: SnakeBodyPart){
            // перемещаемтекущийэлементкпредыдущему
            let moveAction = SKAction.move(to: CGPoint(x: p.position.x, y: p.position.y), duration: 0.1 )
            // запускдействияперемещения
            c.run(moveAction)
        }
        
        //поворотпочасовойстрелке
        func moveClockwise(){
            // смещаемуголна 45 градусов
            angle += CGFloat(Double.pi/2)
        }
        // поворотпротивчасовойстрелки
        func moveCounterClockwise(){
            angle -= CGFloat(Double.pi/2)
        }
}
