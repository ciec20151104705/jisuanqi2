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
    private enum Op : CustomStringConvertible{
        case Operand(Double)
        case UnaryOperation(String,(Double) ->Double)
        case BinaryOperation(String,(Double,Double)->Double)
        
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
    
    init ()
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
    }
    func evaluate()->Double?
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
