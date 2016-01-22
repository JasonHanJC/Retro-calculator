//
//  ViewController.swift
//  Retro-calculator
//
//  Created by Jason miew on 1/22/16.
//  Copyright © 2016 Jason miew. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Equal = "Equal"
        case Empty = "Empty"
    }
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber: String = "0"
    var leftValStr: String = ""
    var rightValStr: String = ""
    var res: String = ""
    var currentOperation: Operation = Operation.Empty
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    @IBAction func numberPressed(btn: UIButton) {
        playSound()
        
        if runningNumber != "0" {
            runningNumber += "\(btn.tag)"
        } else {
            runningNumber = "\(btn.tag)"
        }
        
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }

    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }

    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(Operation.Equal)
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            //Run some math
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
            
                if currentOperation == Operation.Multiply {
                    res = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    res = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    res = "\(Double(leftValStr)! + Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    res = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Equal {
                    leftValStr = rightValStr
                    res = leftValStr
                }
            
                leftValStr  = res
                outputLbl.text = res
            }
            
            currentOperation = op
            
        } else {
            //Store the first number and the operator
            leftValStr = runningNumber;
            runningNumber = "0"
            currentOperation = op
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
}

