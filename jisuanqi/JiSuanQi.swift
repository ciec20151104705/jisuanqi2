//
//  JiSuanQi.swift
//  jisuanqi
//
//  Created by 20151104705 on 2017/3/22.
//  Copyright © 2017年 20151104705. All rights reserved.
//

import Foundation
class JiSuanQi
{
    //用enum（枚举）类型,当你的某样东西在某种情况下是一个值，在另一情况下是另一个值，但是不可能同时拥有这两个值的时候，
    private enum Op : CustomStringConvertible{
        case Operand(Double)//操作数
        case UnaryOperation(String,(Double) ->Double)//运算符
        case BinaryOperation(String,(Double,Double)->Double)//二元运算
        //Swift有个非常酷的特性，你可以将数据与枚举中的case关联起来
        var description:String{
            get {
                switch self {
                case .Operand(let Operand ):
                    return "\(Operand)"
                case .UnaryOperation(let symbol,_ ):
                    return symbol
                case .BinaryOperation(let symbol,_):
                    return symbol
                }
            }
        }
    }
    private var opStack = [Op]()
    
    private var knownOps = Dictionary<String,Op>()
    
    init ()//类初始化的时候必需保证类的所有属性都被初始化，我们使用init这个方法来初始化一个类
    {
        func learnOps(op:Op)
        {
            knownOps[op.description] = op
        }
        knownOps["×"]=Op.BinaryOperation("×"){$0 * $1 }
        knownOps["+"]=Op.BinaryOperation("+"){$0 + $1}
        knownOps["−"]=Op.BinaryOperation("−"){$1 - $0}
        knownOps["÷"]=Op.BinaryOperation("÷"){$1 / $0}
    }
    
    private func evaluate(ops:[Op])->(result:Double?,ramainingOps:[Op])
    {
        if !ops.isEmpty
        {
            var ramainingOps = ops
            let op = ramainingOps.removeLast()
            //用开关语句来判断得到的栈顶Op
            switch op {
            case.Operand(let operand ):
                return(operand,ramainingOps)
            case .UnaryOperation(_ , let operation):
                let operandEvaluation = evaluate(ops: ramainingOps)
            if let operand = operandEvaluation.result
            {
                return(operation(operand),operandEvaluation.ramainingOps)

            }
            case .BinaryOperation( _ ,let operation):
                let op1Evaluation = evaluate(ops: ramainingOps)
                if let operand1 = op1Evaluation.result
                {
                    let op2Evaluation = evaluate(ops: op1Evaluation.ramainingOps)
                    if let operand2 = op2Evaluation.result
                    {
                        return(operation(operand1,operand2),op2Evaluation.ramainingOps)
                    }
                }
            }
          
        }
        return (nil,ops )
    }//标准的递归
    func evaluate()->Double?//如果栈中的元素不能进行运算那么结果会返回一个nil。
    {
        let (result,_) = evaluate(ops: opStack)
        print("\(opStack) = \(result) with \(remainder) left over ")
        return result
    }
    func pushOperand(operand:Double)->Double?{
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    func ZhiXingYunSuan(symbol:String)->Double?
    {
        if let operation = knownOps[symbol]
        {
            opStack.append(operation )
        }
        return evaluate()
    }
}
