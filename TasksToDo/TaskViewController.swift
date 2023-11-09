//
//  TaskViewController.swift
//  TasksToDo
//
//  Created by Mohammad Haris Sofi on 09/11/23.
//

import UIKit

class TaskViewController: UIViewController {
    @IBOutlet var lable : UILabel!;
    var task : String?;
    override func viewDidLoad() {
        super.viewDidLoad()
        lable.text = task;
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "delete", style: .done, target: self, action: #selector(removeItem));
    }
    
    @objc func  removeItem () {
        
        if let count = UserDefaults().value(forKey: "count") as? Int {
            let newCount = count - 1;
            UserDefaults().set(newCount, forKey: "Count");
        }
    }
}
