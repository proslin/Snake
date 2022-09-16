//
//  GameScene.swift
//  snakeProsvetovaIOS
//
//  Created by Lina Prosvetova on 09.09.2022.
//

import SpriteKit
import GameplayKit

    //Категория пересечения объектов
struct CollisionCategories{
    // Тело змеи
 static let Snake: UInt32 = 0x1 << 0
    // Головазмеи
 static let SnakeHead: UInt32 = 0x1 << 1
    // Яблоко
 static let Apple: UInt32 = 0x1 << 2
    // Край сцены (экрана)
 static let EdgeBody: UInt32 = 0x1 << 3
}


class GameScene: SKScene {
    var snake: Snake?
    // вызывается при первом запуске сцены
    override func didMove(to view: SKView) {
        //цветфонасцены
        backgroundColor = SKColor.black // векторисилагравитации
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)// добавляемподдержкуфизики
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)// выключаемвнешниевоздействиянаигру
        self.physicsBody?.allowsRotation = false
        self.physicsWorld.contactDelegate = self
        // устанавливаем категорию взаимодействия с другими объектами
        self.physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
        // устанавливаем категории, с которыми будут пересекаться края сцены
        self.physicsBody?.collisionBitMask = CollisionCategories.Snake | CollisionCategories.SnakeHead
        // включаемотображениеотладочнойинформации
        view.showsPhysics = true
        //создаемноду(объект)
        let counterClockwiseButton = SKShapeNode()
        // задаемформукруга
        counterClockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        // указываемкоординатыразмещения
        counterClockwiseButton.position = CGPoint(x: view.scene!.frame.minX+30, y: view.scene!.frame.minY+30)
        // цветзаливки
        counterClockwiseButton.fillColor = UIColor.gray
        // цветрамки
        counterClockwiseButton.strokeColor = UIColor.gray
        // толщинарамки
        counterClockwiseButton.lineWidth = 10
        // имяобъектадлявзаимодействия
        counterClockwiseButton.name = "counterClockwiseButton"
        //Добавляемнасцену
        self.addChild(counterClockwiseButton)
        // Поворотпочасовойстрелке
        let clockwiseButton = SKShapeNode()
        clockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        clockwiseButton.position = CGPoint(x: view.scene!.frame.maxX-80, y: view.scene!.frame.minY+30)
        clockwiseButton.fillColor = UIColor.gray
        clockwiseButton.strokeColor = UIColor.gray
        clockwiseButton.lineWidth = 10
        clockwiseButton.name = "clockwiseButton"
        self.addChild(clockwiseButton)
        
        createApple()
        // создаем змею по центру экрана и добавляем ее насцену
        snake = Snake(atPoint: CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY))
        self.addChild(snake!)
    }
    
    //вызывается принажатии на экран
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // перебираемвсеточки, кудаприкоснулсяпалец
        for touch in touches {
            // определяемкоординатыкасаниядляточки
            let touchLocation = touch.location(in: self)
            // проверяем, естьлиобъектпоэтимкоординатам, иеслиесть, тоненашалиэтокнопка
            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode, touchedNode.name == "counterClockwiseButton" || touchedNode.name == "clockwiseButton" else { return }
            // еслиэтонашакнопка, заливаемеезеленым
            touchedNode.fillColor = .green
            // определяем, какаякнопканажата, иповорачиваемвнужнуюсторону
            if touchedNode.name == "counterClockwiseButton" {
                snake!.moveCounterClockwise()
            } else if touchedNode.name == "clockwiseButton" {
                snake!.moveClockwise()
            }
        }
    }
    
    
    //вызываетсяприпрекращениинажатиянаэкран
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // повторяем все тоже самое для действия, когда палец отрывается от экрана
        for touch in touches {
            let touchLocation = touch.location(in: self)
            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode, touchedNode.name == "counterClockwiseButton" || touchedNode.name == "clockwiseButton"else {return }
            // но делаем цвет снова серым
            touchedNode.fillColor = UIColor.gray
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode, touchedNode.name == "counterClockwiseButton" || touchedNode.name == "clockwiseButton"else {return }
            // но делаем цвет снова серым
            touchedNode.fillColor = UIColor.gray
        }
    }
    // вызывается при обрыве нажатия на экран, например, если телефон примет звонок и свернет приложение
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    // вызываетсяприобработкекадровсцены
    override func update(_ currentTime: TimeInterval) {
        snake!.move()
    }
    
    //Создаемяблоковслучайнойточкесцены
    func createApple(){
        // Случайнаяточканаэкране
        let randX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX-5)) + 1)
        let randY = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY-5)) + 1)// Создаемяблоко
        let apple = Apple(position: CGPoint(x: randX, y: randY))// Добавляемяблоконасцену
        self.addChild(apple)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        // логическая суммама соксоприкоснувшихся объектов
        let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        // вычитаем из суммы голову змеи, и у нас остается маска второго объекта
        let collisionObject = bodyes ^ CollisionCategories.SnakeHead
        // проверяем, что это за второй объект
        switch collisionObject {
            case CollisionCategories.Apple:
            // проверяем, что это яблоко
            // яблоко – это один из двух объектов, которые соприкоснулись. Используем тернарный оператор, чтобы вычислить, какой именно
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            // добавляем к змее еще одну секцию
            snake?.addBodyPart()
            // удаляем съеденное яблоко со сцены
            apple?.removeFromParent()// создаем новое яблоко
            createApple()
        case CollisionCategories.EdgeBody:
            // проверяем, что это стенка экрана
            snake?.removeFromParent()
            snake = Snake(atPoint: CGPoint(x: view!.scene!.frame.midX, y: view!.scene!.frame.midY))
            self.addChild(snake!)
            
            default:
            break
            
        }
    }
    
}
