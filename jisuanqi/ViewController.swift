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

    @IBAction func operate(_ sender: UIButton) {
        let operation = sender.currentTitle!
        if userlslnTheMiddleOfTypingANumber{
            enter()
        }
        switch operation {
        case "×":perfomOperation(operation: {(op1:Double,op2:Double)->Double in
            return op1 * op2
        })
        case "÷":perfomOperation(operation: {(op1:Double,op2:Double)->Double in
            return op2 / op1})
        case "+":perfomOperation(operation: {(op1:Double,op2:Double)->Double in
            return op1 + op2})
        case "−":perfomOperation(operation: {(op1:Double,op2:Double)->Double in
            return op1 - op2})
        default:
            break
        }
    }
    func perfomOperation(operation:(Double,Double)->Double){
        if operandStack.count>=2 {
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
    }
    }
    @IBAction func appendDight(_ sender: UIButton) {
        let dight = sender.currentTitle!
        if userlslnTheMiddleOfTypingANumber{
            display.text=display.text!+dight
        }else{
            display.text=dight
            userlslnTheMiddleOfTypingANumber=true
        }
    }
    var operandStack = Array<Double>()
    @IBAction func enter() {
        userlslnTheMiddleOfTypingANumber=false
        operandStack.append(displayValue)
        print("operandStack=\(operandStack)")
     
    }
    var displayValue:Double{
        get {
            return NumberFormatter().number(from: display.text!)!.doubleValue
    }
        set {
            display.text="\(newValue)"
            userlslnTheMiddleOfTypingANumber = false
        }
        
}

}
