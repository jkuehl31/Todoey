//
//  ViewController.swift
//  Todoey
//
//  Created by John Kuehl on 9/11/18.
//  Copyright © 2018 Winners Win. All rights reserved.
//

import UIKit

class TodoListViewControllerViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Exercise"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Meditate"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Read"
        itemArray.append(newItem3)
        
        
      //  if let items = defaults.array(forKey: "TodoListArray") as? [String] {itemArray = items
     //   }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK - TAbleview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
    
        //this is the same as the line above
        //if item.done == true {
           // cell.accessoryType = .checkmark
      //  } else {
      //      cell.accessoryType = .none
      //  }
        
        return cell
    }

//MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        //This is the same as the code above
      //if itemArray[indexPath.row].done == false {
        //    itemArray[indexPath.row].done = true
     //   } else {
     //           itemArray[indexPath.row].done = false
    //    }
        
        tableView.reloadData()
    
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user click the Add Item buttom on our UIAlert
            
            let newItem = Item()
            newItem.title = textField.text!
            
             self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
          textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
}

