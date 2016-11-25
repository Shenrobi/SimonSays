//
//  ViewController.swift
//  SimonSays
//
//  Created by Terrell Robinson on 11/5/16.
//  Copyright © 2016 FlyGoody. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var simonSaysLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var gameButton: UIButton!
    
    var timeInt = 0
    var scoreInt = 0
    var gameModeInt = 0
    
    var timer = Timer()
    var simonTimer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeInt = 60
        scoreInt = 0
        gameModeInt = 0
        
        timeLabel.text = String("Time: \(timeInt)")
        scoreLabel.text = String("Score: \(scoreInt)")
        
        swipeRecognizer()
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func gameButtonPressed(_ sender: AnyObject) {
        
        startGame()
        
    }
    
    
    
    // Helper Methods
    
    func startGame() {
        
        if timeInt == 60 {
            
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.updateGameTimer), userInfo: nil, repeats: true)
            
            gameModeInt = 1 // enables swipe gestures
            
            // Once the game button is pressed, "START GAME" will be disabled until the timer ends
            
            gameButton.isEnabled = false
            gameButton.alpha = 0.25
            
            self.simonSays() // triggers simon says function
            
        } else if timeInt == 0 {
            
            // Everything Resets
            
            timeInt = 60
            scoreInt = 0
            
            timeLabel.text = String("Time: \(timeInt)")
            scoreLabel.text = String("Score: \(scoreInt)")
            
            simonSaysLabel.text = "Simon Says"
            
            gameButton.setTitle("Start Game", for: .normal)
            
        }
        
    }
    
    
    func updateGameTimer() {
        
        timeInt -= 1
        timeLabel.text = String("Time: \(timeInt)")
        
        if timeInt == 0 {
            
            timer.invalidate()
            simonTimer.invalidate()
            
            simonSaysLabel.text = "Game Over"
            
            gameModeInt = 0 // disables swipe gestures
            
            // Game Button Comes Back To Life... Turns into "Restart Game"
            
            gameButton.isEnabled = true
            gameButton.alpha = 1
            gameButton.setTitle("Restart Game", for: .normal)
            
        }
        
    }
    
    
    func simonSays() {
        
        let simonSaysArray = ["Simon Says: Swipe Right", "Swipe Left", "Simon Says: Swipe Left", "Swipe Up", "Simon Says: Swipe Up", "Swipe Right", "Simon Says: Swipe Down", "Swipe Down"]
        
        let randomPhrase = Int(arc4random_uniform(UInt32(simonSaysArray.count)))
        simonSaysLabel.text = simonSaysArray[randomPhrase]
        
        simonTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.simonSays), userInfo: nil, repeats: false) // Don't want it to repeat itself.
        
    }
    
    
    func swipeGestures(sender: UISwipeGestureRecognizer) {
        
        if gameModeInt == 1 {
            
            if sender.direction == .right {
                
                
                simonTimer.invalidate() // Will allow the user to see the outcome of their action
                swipeRight()
            
        
            } else if sender.direction == .left {
                
                simonTimer.invalidate()
                swipeLeft()
                
            } else if sender.direction == .up {
                
                simonTimer.invalidate()
                swipeUp()
                
            } else if sender.direction == .down {
                
                simonTimer.invalidate()
                swipeDown()
                
            }
            
        }
        
    }
    
    
    func swipeRecognizer() {
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeGestures))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeGestures))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeGestures))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeGestures))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUp)
        
    }
    
    
    
    // Game Logic Functions
    // Will work on a better way to do this
    
    func swipeRight() {
        
        if simonSaysLabel.text == "Simon Says: Swipe Right" {
            
            scoreInt += 5
            scoreLabel.text = String("Score: \(scoreInt)")
            
            self.simonSays()
            
        } else if simonSaysLabel.text == "Swipe Left" || simonSaysLabel.text == "Swipe Down" || simonSaysLabel.text == "Swipe Right" || simonSaysLabel.text == "Swipe Up" {
            
            scoreInt -= 2
            scoreLabel.text = String("Score: \(scoreInt)")
            
            self.simonSays()
            
        } else if simonSaysLabel.text == "Simon Says: Swipe Left" || simonSaysLabel.text == "Simon Says: Swipe Up" || simonSaysLabel.text == "Simon Says: Swipe Down" {
            
            scoreInt -= 5
            scoreLabel.text = String("Score: \(scoreInt)")
            
            self.simonSays()
            
        }
        
        
    }

    
    func swipeLeft() {
        
        if simonSaysLabel.text == "Simon Says: Swipe Left" {
            
            scoreInt += 5
            scoreLabel.text = String("Score: \(scoreInt)")
            
            self.simonSays()
            
        } else if simonSaysLabel.text == "Swipe Left" || simonSaysLabel.text == "Swipe Down" || simonSaysLabel.text == "Swipe Right" || simonSaysLabel.text == "Swipe Up" {
            
            scoreInt -= 2
            scoreLabel.text = String("Score: \(scoreInt)")
            
            self.simonSays()
            
        } else if simonSaysLabel.text == "Simon Says: Swipe Right" || simonSaysLabel.text == "Simon Says: Swipe Up" || simonSaysLabel.text == "Simon Says: Swipe Down" {
            
            scoreInt -= 5
            scoreLabel.text = String("Score: \(scoreInt)")
            
            self.simonSays()
            
            
        }
        
        
    }
    
    
    func swipeUp() {
        
        if simonSaysLabel.text == "Simon Says: Swipe Up" {
            
            scoreInt += 5
            scoreLabel.text = String("Score: \(scoreInt)")
            
            self.simonSays()
            
        } else if simonSaysLabel.text == "Swipe Left" || simonSaysLabel.text == "Swipe Down" || simonSaysLabel.text == "Swipe Right" || simonSaysLabel.text == "Swipe Up"{
            
            scoreInt -= 2
            scoreLabel.text = String("Score: \(scoreInt)")
            
            self.simonSays()
            
        } else if simonSaysLabel.text == "Simon Says: Swipe Right" || simonSaysLabel.text == "Simon Says: Swipe Left" || simonSaysLabel.text == "Simon Says: Swipe Down" {
            
            scoreInt -= 5
            scoreLabel.text = String("Score: \(scoreInt)")
            
            self.simonSays()
            
        }
        
        
    }
    
    
    func swipeDown() {
        
        if simonSaysLabel.text == "Simon Says: Swipe Down" {
            
            scoreInt += 5
            scoreLabel.text = String("Score: \(scoreInt)")
            
            self.simonSays()
            
        } else if simonSaysLabel.text == "Swipe Left" || simonSaysLabel.text == "Swipe Down" || simonSaysLabel.text == "Swipe Right" || simonSaysLabel.text == "Swipe Up"{
            
            scoreInt -= 2
            scoreLabel.text = String("Score: \(scoreInt)")
            
            self.simonSays()
            
        } else if simonSaysLabel.text == "Simon Says: Swipe Right" || simonSaysLabel.text == "Simon Says: Swipe Left" || simonSaysLabel.text == "Simon Says: Swipe Up" {
            
            scoreInt -= 5
            scoreLabel.text = String("Score: \(scoreInt)")
            
            self.simonSays()
            
        }

        
    }
    
    
    
    
    
    
    
    
    
    
}

