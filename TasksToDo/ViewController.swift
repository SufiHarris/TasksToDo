//
//  ViewController.swift
//  TasksToDo
//
//  Created by Mohammad Haris Sofi on 09/11/23.
//

import UIKit

class ViewController: UIViewController {
    var tasks = [String]()
    
    @IBOutlet var tableView : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        //Setup
        
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        updateTasks();
    }

    func updateTasks() {
        tasks.removeAll()
        guard  let count  = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        for x in 0..<count {
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                tasks.append(task)
            }
        }
        tableView.reloadData()
       
    }
}
extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let vc =  storyboard?.instantiateViewController(identifier: "task") as! TaskViewController
        vc.title = tableView.cellForRow(at: indexPath)?.textLabel?.text
        vc.task = tableView.cellForRow(at: indexPath)?.textLabel?.text
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    
    
    @IBAction func didTapBtn () {
        let vc =  storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Tasl"
        DispatchQueue.main.async {
            vc.update = {
                self.updateTasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

