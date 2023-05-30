//
//  CalcLogTableViewModel.swift
//  Calculator
//
//  Created by 이치훈 on 2023/05/28.
//

import Foundation
import CoreData

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
    
    func fetchData() {
        let fetchRequest: NSFetchRequest<CalcLog> = CalcLog.fetchRequest()
        
        let context = Manager.shared.persistentContainer.viewContext
        do{
            try self.setLog(context.fetch(fetchRequest))
        }catch{
            print(error)
        }
    }
    
}
