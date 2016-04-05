//
//  GameVC.swift
//  BrainTeaser
//
//  Created by Thiago Costa on 3/30/16.
//  Copyright © 2016 Thiago Costa. All rights reserved.
//

import UIKit
import pop

class GameVC: UIViewController {
    
    @IBOutlet weak var yesBtn: CustomButton!
    @IBOutlet weak var noBtn: CustomButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet var answerVisual: UIImageView!
    @IBOutlet var restartBtn: CustomButton!
    
    var currentCard: Card!
    var originalCard: String!
    var timer: NSTimer!
    var x = 10 //this is used for the timer
    var correct = 0
    var incorrect = 0
    var clearTimer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameSetup()
    }
    
    
    func gameSetup() {
        correct = 0
        incorrect = 0
        yesBtn.hidden = false
        yesBtn.setTitle("START", forState: .Normal)
        x = 10
        currentCard = createCardFromNib("Card")
        originalCard = currentCard.currentShape
        //currentCard.center = AnimationEngine.offScreenRightPosition
        self.view.addSubview(currentCard)
        titleLbl.text = "Remember this image"
        timerLbl.text = "00:\(x)"
        AnimationEngine.animateToPosition(currentCard, position: AnimationEngine.screenCenterPosition, completion:
            { (anim: POPAnimation!, finished: Bool) -> Void in
        })
    }
    
    
    @IBAction func yesPressed(sender: UIButton) {
        if sender.titleLabel?.text == "YES" {
            checkAnswer("yes")
        } else {
            titleLbl.text = "Does this card match the Orignal?"
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(GameVC.updateTimerLabel), userInfo: nil, repeats: true)
            
        }
        
        showNextCard()
    }
    
    @IBAction func noPressed(sender: AnyObject) {
        checkAnswer("no")
        showNextCard()
    }
    
    func showNextCard() {
        
        if let current = currentCard {
            let cardToRemove = current
            currentCard = nil
            
            AnimationEngine.animateToPosition(cardToRemove, position: AnimationEngine.offScreenLeftPosition, completion: { (anim:POPAnimation!, finished: Bool) -> Void in
                cardToRemove.removeFromSuperview()
            })
        }
        
        if let next = createCardFromNib("Card") {
            next.center = AnimationEngine.offScreenRightPosition
            self.view.addSubview(next)
            currentCard = next
            
            if noBtn.hidden {
                noBtn.hidden = false
                yesBtn.setTitle("YES", forState: .Normal)
            }
            
            AnimationEngine.animateToPosition(next, position: AnimationEngine.screenCenterPosition, completion: { (anim: POPAnimation!, finished: Bool) -> Void in
                
            })
            
        }
        
        
    }
    
    @IBAction func restartBtnPressed(sender: UIButton!) {
        
        sender.hidden = true
        
        if let current = currentCard {
            let cardToRemove = current
            currentCard = nil
            
            AnimationEngine.animateToPosition(cardToRemove, position: AnimationEngine.offScreenLeftPosition, completion: { (anim:POPAnimation!, finished: Bool) -> Void in
                cardToRemove.removeFromSuperview()
            })
        }
        
        gameSetup()
    }

    
    func createCardFromNib(name: String!) -> Card? {
        return NSBundle.mainBundle().loadNibNamed(name, owner: self, options: nil)[0] as? Card
    }
    
    func stopGame() {
        noBtn.hidden = true
        yesBtn.hidden = true
        
        if let current = currentCard {
            let cardToRemove = current
            currentCard = nil
            
            AnimationEngine.animateToPosition(cardToRemove, position: AnimationEngine.offScreenLeftPosition, completion: { (anim:POPAnimation!, finished: Bool) -> Void in
                cardToRemove.removeFromSuperview()
            })
        }
        
        if let next = createCardFromNib("Results") {
            next.center = AnimationEngine.offScreenRightPosition
            self.view.addSubview(next)
            currentCard = next
            
            self.currentCard.correctLbl.text = "\(correct)"
            self.currentCard.incorrectLbl.text = "\(incorrect)"
            self.currentCard.shapeImage.hidden = true
            titleLbl.text = "Check your score below!"
            
            AnimationEngine.animateToPosition(next, position: AnimationEngine.screenCenterPosition, completion: { (anim: POPAnimation!, finished: Bool) -> Void in
                self.restartBtn.hidden = false
            })
        }
    }
    
    func updateTimerLabel() {
        if x == 0 {
            timer.invalidate()
            stopGame()
            timerLbl.text = "Time's Up"
        }else {
            timerLbl.text = "00:\(x)"
            x -= 1
        }
    }
    
    
    func clear() {
        answerVisual.hidden = true
        clearTimer.invalidate()
    }
    
    func answerVisualChecks(image: String!)
    {
        answerVisual.image = UIImage(named: image)
        answerVisual.hidden = false
    }

    
    func checkAnswer(answer: String) {
        clearTimer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(GameVC.clear), userInfo: nil, repeats: true)
        
        if (originalCard == currentCard.currentShape && answer == "yes") || (originalCard != currentCard.currentShape && answer == "no"){
            correct += 1
            answerVisualChecks("yes")
        }else {
            incorrect += 1
            answerVisualChecks("no")
            
        }
    } 
}













