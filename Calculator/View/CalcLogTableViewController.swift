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
        //tableView.isEditing = true
        
        self.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.register(CalcLogTableViewCell.self, forCellReuseIdentifier: "CalcLogTableViewCell")
        
        self.fetchData()
        self.tableView.reloadData()
    }
    
    //MARK: - Care Data
    
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
        return logList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CalcLogTableViewCell", for: indexPath) as? CalcLogTableViewCell{
            
            if let hasLog = logList[indexPath.row].log{
                cell.logValue.text = hasLog
            }else{
                cell.logValue.text = "noLogData"
            }
            
            if let hasDate = logList[indexPath.row].date {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
                let dataString = formatter.string(from: hasDate)
                cell.dateValue.text = dataString
            }else{
                cell.dateValue.text = "noDateData"
            }
            
            return cell
        }else{
            let cell = CalcLogTableViewCell(style: .default, reuseIdentifier: "CalcLogTableViewCell")
                return cell
        }
        
        
    }
    
    //cell delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let loglist = logList[indexPath.row]
            
            context.delete(loglist)
            
            do{
                try context.save()
            }catch{
                print(error)
            }
            
            logList.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
}
