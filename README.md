# CalculatorApp
계산기앱

# Calculation Screen
![Simulator Screen Shot - iPhone 14 Pro - 2023-03-11 at 18 06 47](https://user-images.githubusercontent.com/117021317/230726085-879f0650-e356-43e9-a20c-a22225115b46.png)

# Save CoreData
``` swift
fileprivate func saveLog() {
        let object = CalcLog(context: context)
        object.log = logBuffer
        object.date = Date()
        object.uuid = UUID()
        
        do {
            try context.save()
        } catch {
            print("Failed saving log with error: \(error)")
        }
    }
```

# Calculation Log Screen
![Simulator Screenshot - iPhone 14 Pro - 2023-04-08 at 23 16 30](https://github.com/logicHoon-bit/CalculatorApp/blob/main/Simulator%20Screenshot%20-%20iPhone%2014%20Pro%20-%202023-05-21%20at%2018.38.21.png)

# Use CoreData
``` swift
func fetchData() {
        let fetchRequest: NSFetchRequest<CalcLog> = CalcLog.fetchRequest()
        
        let context = appDelegate.persistentContainer.viewContext
        do{
            self.logList = try context.fetch(fetchRequest)
        }catch{
            print(error)
        }
    }
```

# Delete CoreData
``` swift
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
 ```
