//
//  ViewController.swift
//  Me&Mo
//
//  Created by HYUNHONG BYUN on 2020/04/21.
//  Copyright © 2020 BBANPRO. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadItem()
    }
    
    //MARK: - Add New Categories

    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        var field = UITextField()
        
        let alert = UIAlertController(title: "메모 카테고리를 설정한다", message: "입력해라", preferredStyle: .alert)
        alert.addTextField { (text) in
            field = text
            field.placeholder = "Tlqkf!"
        }
        
        let add = UIAlertAction(title: "whwRk!", style: .default) { (action) in
            let newCategory = Category(context: self.context)
            newCategory.name = field.text
            self.categories.append(newCategory)
            self.saveItem()
        }
        let cancel = UIAlertAction(title: "slal!", style: .cancel) { (action) in
            
        }
        alert.addAction(add)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    //MARK: - Delete a Category
    
    
    //MARK: - Table View Data Source Method
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.categoryCellIdentifier, for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
    
    //MARK: - Data CRUD Method
    
    func saveItem() {
        do {
            try context.save()
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
    
    func loadItem(request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            let loadedItem = try context.fetch(request)
            categories = loadedItem
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
    
    
    //MARK: - Go To Memo
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.segueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MemoTableViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
}

