//
//  EntryViewController.swift
//  TasksToDo
//
//  Created by Mohammad Haris Sofi on 09/11/23.
//

import UIKit

class EntryViewController: UIViewController {
    @IBOutlet var feild : UITextField!
    var update : (()-> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feild.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "done", style: .done, target: self, action: #selector(saveFile))

    }
}


extension EntryViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       saveFile()
       return true
    }
    
    @objc func saveFile() {
        guard let text = feild.text , !text.isEmpty else {
            return
        }
        if let count = UserDefaults().value(forKey: "count") as? Int {
            let newCount = count + 1;
            UserDefaults().set(newCount, forKey: "count");
            UserDefaults().set(text, forKey: "task_\(newCount)")
            }
         update?()
        navigationController?.popViewController(animated: true)
    }
}
