//
//  GroceryListViewController.swift
//  Perfectionist
//
//  Created by RAJAN on 1/1/18.
//  Copyright © 2018 RAJAN. All rights reserved.
//

import UIKit

class GroceryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GroceryTableViewCellDelegate {

    var groceryList: Array<String>? = ["Bread","Nutella","Weizenmehl","Cheese"]
    
    @IBOutlet weak var groceryTableView: UITableView!
    
    required init?(coder aDecoder: NSCoder) {

        let oldList = UserDefaults.standard.array(forKey: "groceryList") as? Array<String>
        if oldList?.isEmpty == false {
            self.groceryList = oldList
        }
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableView delegate and datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (groceryList?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groceryCell") as! GroceryTableViewCell
        cell.set(indexpath: indexPath, delegate: self, text:groceryList?[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            groceryList?.remove(at: indexPath.row)
            updateGroceries()
        }
    }
    
    // MARK: - Button actions
    
    @IBAction func addCellButtonClicked(_ sender: Any) {
        
        groceryList?.append("new item")
        updateGroceries()
    }

    
    // MARK: - GroceryTableViewCellDelegate
    
    func didUpdateTextContent(text: String?, indexPath: IndexPath?) {
        let index = indexPath!.row
        groceryList?.remove(at: index)
        groceryList?.insert(text!, at: index)
        updateGroceries()
    }
    
    // MARK: - Methods
    
    func updateGroceries() {
        UserDefaults.standard.set(groceryList, forKey: "groceryList")
        groceryTableView.reloadData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
