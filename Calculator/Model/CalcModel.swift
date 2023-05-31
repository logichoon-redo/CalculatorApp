//
//  CalcModel.swift
//  Calculator
//
//  Created by 이치훈 on 2023/05/07.
//

import Foundation

struct CalcModel {
    
    var logBuffer: String = ""
    var operandBuffer: String = "0"
    var isFirstNum: Bool = true
    var isShowResult: Bool = false
    var resultValue: Double?
    
}
