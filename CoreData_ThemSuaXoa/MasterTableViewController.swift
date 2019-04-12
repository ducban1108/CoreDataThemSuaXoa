//
//  MasterTableViewController.swift
//  CoreData_ThemSuaXoa
//
//  Created by Just Kidding on 4/9/19.
//  Copyright © 2019 Just Kidding. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController {

    var person: [Person] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchObject()
        
    }
    
    
    //
    func fetchObject() {
        if let data = (try? AppDelegate.context.fetch(Person.fetchRequest()) as [Person]) {
            person = data
//            self.arrName = data.map{$0.name ?? ""}
//            self.arrNumber = data.map{$0.age }
//            self.arrImage = data.map{$0.image} as! [UIImage]
//            self.tableView.reloadData()
            tableView.reloadData()
            
            
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return person.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MasterTableViewCell

        cell.nameLabel.text = person[indexPath.row].name
        cell.nameLabel.textColor = UIColor.red
        cell.ageLabel.text = String(person[indexPath.row].age)
        cell.masterImageView.image = person[indexPath.row].image as? UIImage
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
             let bucket = segue.destination as? ViewController
                bucket?.data = person[indexPath.row]
                bucket?.index = indexPath.row
        }
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            AppDelegate.context.delete(person[indexPath.row])
            AppDelegate.saveContext()
            person.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        } 
    }
    
    

    

}
