//
//  CalcLogTableViewController.swift
//  Calculator
//
//  Created by 이치훈 on 2023/03/12.
//

import UIKit
import CoreData

class CalcLogTableViewController: UITableViewController {

    //MARK: - Properties
    
    var navigationBar: UINavigationBar!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var logList = [CalcLog]()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.largeContentTitle = "Log"
        
        self.fetchData()
    }
    
    func fetchData() {
        let fetchRequest: NSFetchRequest<CalcLog> = CalcLog.fetchRequest()
        
        let context = appDelegate.persistentContainer.viewContext
        do{
            self.logList = try context.fetch(fetchRequest)
        }catch{
            print(error)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.logList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalcLogTableViewCell") as! CalcLogTableViewCell
        
        cell.logValue.text = logList[indexPath.row].log
        
        if let hasDate = logList[indexPath.row].date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            let dataString = formatter.string(from: hasDate)
            cell.dateValue.text = dataString
        }else{
            cell.dateValue.text = ""
        }
        
        print("will cellForRowAt")
        return cell
    }
    
    
}
