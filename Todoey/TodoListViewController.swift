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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.pList")
    
    //let defaults = UserDefaults.standard
    //Defaults are not good for saving lots of info

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(dataFilePath)
        
        //let newItem = Item()
        //newItem.title = "Exercise"
       // itemArray.append(newItem)
        
        //let newItem2 = Item()
        //newItem2.title = "Meditate"
        //itemArray.append(newItem2)
        
        //let newItem3 = Item()
        //newItem3.title = "Read"
       // itemArray.append(newItem3)
        
        //All these hard coded items are in loadItems
        
        loadItems()
       
        
        
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
        
        saveItems()
        
        //This is the same as the code above
      //if itemArray[indexPath.row].done == false {
        //    itemArray[indexPath.row].done = true
     //   } else {
     //           itemArray[indexPath.row].done = false
    //    }
        
    
        
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
            
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
          textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")            }
        }

    }
}

