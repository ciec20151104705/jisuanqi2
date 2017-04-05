//
//  ViewController.swift
//  jisuanqi
//
//  Created by 20151104705 on 2017/3/14.
//  Copyright © 2017年 20151104705. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var display: UILabel!
    var userlslnTheMiddleOfTypingANumber:Bool=false
    
    var brain = JiSuanQi()
    
    @IBAction func appendDight(_ sender: UIButton) {
        let dight = sender.currentTitle!

        if userlslnTheMiddleOfTypingANumber{
            display.text=display.text!+dight
            
        }else{
            display.text=dight
            userlslnTheMiddleOfTypingANumber=true
        }
    
        }
    
    @IBAction func operate(_ sender: UIButton) {
        if userlslnTheMiddleOfTypingANumber
        {
            enter()
        }
        if let operation = sender.currentTitle{
        
            if let result = brain.ZhiXingYunSuan(symbol: operation)
            {
                displayValue = result
            }else
            {
                displayValue = 0
            }
        }
}
    var operandStack = Array<Double>()
    @IBAction func enter() {
        userlslnTheMiddleOfTypingANumber=false
        if let result = brain.pushOperand(operand: displayValue)
        {
           displayValue=result
        }else {
        displayValue = 0
        }
       
     
    }
    var displayValue:Double{
        get {
            return NumberFormatter().number(from: display.text!)!.doubleValue
            }
        set {
            display.text="\(newValue)"
          
            }
        
    }

}
