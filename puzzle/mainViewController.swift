//
//  mainViewController.swift
//  puzzle
//
//  Created by user on 12/20/20.
//

import UIKit
import Foundation

class mainViewController: UIViewController {
    
    @IBOutlet weak var btn1: UIButton!
    
    @IBOutlet weak var btn2: UIButton!
    
    @IBOutlet weak var btn3: UIButton!
    
    @IBOutlet weak var btn4: UIButton!
    
    @IBOutlet weak var btn5: UIButton!
    
    @IBOutlet weak var btn6: UIButton!
    
    @IBOutlet weak var btn7: UIButton!
    
    @IBOutlet weak var btn8: UIButton!
    
    @IBOutlet weak var btn9: UIButton!
    
    @IBOutlet weak var btn10: UIButton!
    
    @IBOutlet weak var btn11: UIButton!
    
    @IBOutlet weak var btn12: UIButton!
    
    @IBOutlet weak var btn13: UIButton!
    
    @IBOutlet weak var btn14: UIButton!
    
    @IBOutlet weak var btn15: UIButton!
    
    @IBOutlet weak var btn16: UIButton!
    
   
    @IBOutlet weak var time: UILabel!
    
    
    @IBOutlet weak var steps: UILabel!
    
    var btns = [UIButton]()
    var whiteIndex = 15
    var numberOfMovement = 0
    var timer = Timer()
    var minuts = 0
    var seconds = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        initGame()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func restart(_ sender: Any) {
        initGame()
    }
    
    
    func initGame() {
        btns = []
        btns.append(btn1)
        btns.append(btn2)
        btns.append(btn3)
        btns.append(btn4)
        btns.append(btn5)
        btns.append(btn6)
        btns.append(btn7)
        btns.append(btn8)
        btns.append(btn9)
        btns.append(btn10)
        btns.append(btn11)
        btns.append(btn12)
        btns.append(btn13)
        btns.append(btn14)
        btns.append(btn15)
        btns.append(btn16)
        
        numberOfMovement = 0
        steps.text = "\(numberOfMovement)"
        
        minuts = 0
        seconds = 0
        time.text = String(format: "%02d", minuts) + ":" + String(format: "%02d", seconds)
        timer.invalidate()
        timer = Timer()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeTime), userInfo: nil, repeats: true)
        
        var usedIndexes = [Int]()
        var visualIndex:Int
        for (index, btn) in btns.enumerated() {
            
            repeat {
                visualIndex = Int.random(in: 1...16)
            }while usedIndexes.contains(visualIndex)
            usedIndexes.append(visualIndex)
            
            
            btn.tag = index
            makeBlue(index: index, text: "\(visualIndex)")
            if visualIndex == 16 {
                makeWhite(index: index)
                whiteIndex = index
            }
        }
        
    }

    
    @IBAction func itemClicked(_ sender: UIButton) {
        let clickedIndex = sender.tag
        
        if clickedIndex-4 == whiteIndex
            || clickedIndex+4 == whiteIndex
            || clickedIndex+1 == whiteIndex
            || clickedIndex-1 == whiteIndex
        {
            var clickedText:String
            clickedText = sender.titleLabel?.text ?? ""
            makeWhite(index: clickedIndex)
            makeBlue(index: whiteIndex, text: clickedText)
            whiteIndex = clickedIndex
            
            numberOfMovement += 1
            steps.text = "\(numberOfMovement)"
        }
        
        checkResult()
    }
    
    
    func makeWhite(index:Int) {
        let btn = btns[index]
        btn.setTitle("", for: .normal)
        btn.backgroundColor = UIColor.white
        btn.removeTarget(self, action: #selector(itemClicked), for: .touchUpInside)
    }
    
    func makeBlue(index:Int, text:String) {
        let btn = btns[index]
        btn.setTitle(text, for: .normal)
        btn.backgroundColor = UIColor.systemBlue
        btn.addTarget(self, action: #selector(itemClicked), for: .touchUpInside)
    }
    
    @objc func changeTime() {
        seconds += 1;
        if seconds == 60 {
            seconds = 0;
            minuts += 1;
        }
        
        time.text = String(format: "%02d", minuts) + ":" + String(format: "%02d", seconds)
    }
    
    func checkResult() {
        var ok = true;
        for (index, btn) in btns.enumerated() {
            if index == 15 {
                continue
            }
            if "\(index+1)" != btn.titleLabel?.text {
                ok = false
            }
        }
        
        if ok {
            self.timer.invalidate()
            for btn in btns {
                btn.removeTarget(self, action: #selector(itemClicked), for: .touchUpInside)
            }
        }
    }

}
