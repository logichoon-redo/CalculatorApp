//
//  CalcLogTableViewModel.swift
//  Calculator
//
//  Created by 이치훈 on 2023/05/28.
//

import Foundation

//enum LogValueError: Error {
//    case ValueIsNil
//}

class CalcLogTableViewModel {
    
    var logModel = LogModel()
    
    func setLog(_ item: [CalcLog]) {
        logModel.logList = item
    }
    
    func getLogCount() -> Int {
        logModel.logList.count
    }
    
    func getLogList(_ at: Int) -> CalcLog {
        logModel.logList[at]
    }
    
    func getLog(_ at: Int) -> String? {
        logModel.logList[at].log
    }
    
    func getData(_ at: Int) -> Date? {
        logModel.logList[at].date
    }
    
    func removeLogList(_ at: Int) {
        logModel.logList.remove(at: at)
    }
    
}
