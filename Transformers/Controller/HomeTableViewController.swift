//
//  TableViewController.swift
//  Transformers
//
//  Created by Alexander Sundiev on 2019-10-07.
//  Copyright © 2019 Alexander Sundiev. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    // MARK: - Properties
    let cellId = "cellId"

    // MARK: - Events
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: cellId)
        
        setupNavbar()
    }
    
    @objc private func refreshOptions(sender: UIRefreshControl){
        // Perform actions to refresh the content
        handleRefresh()
        // and then dismiss the control
        sender.endRefreshing()
    }
    
    // MARK: - UI Elements
    let logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "Transformers Logo")
        imageView.tintColor = .gray
        return imageView
    }()
    
    lazy var battleButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Battle Icon"), style: .plain, target: self, action: #selector(handleBattle))
        barButton.tintColor = .gray
        return barButton
    }()
    
    lazy var createNewButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: #imageLiteral(resourceName: "round_add_black_24pt"), style: .plain, target: self, action: #selector(handleCreateNew))
        barButton.tintColor = .gray
        return barButton
    }()
    
    // MARK: Handlers
    @objc func handleBattle(){
        print("Battle button tapped")
    }
    
    @objc func handleCreateNew(){
        print("Create button tapped")
        let createVC = EditTransformerViewController()
        // possible delegate <----
        self.navigationController?.show(createVC, sender: self)
    }
    
    @objc func handleRefresh(){
        print("Refresh Initiated")
    }
    
    @objc func handleEdit(indexPath: IndexPath){
        print("Edit button tapped at cell \(indexPath)")
    }
    
    @objc func handleRemove(indexPath: IndexPath){
        print("Remove button tapped at cell \(indexPath)")
    }
    
    // MARK: View Setup
    private func setupNavbar(){
//        navigationItem.title = "Transformers"
//        let logoView = UIImageView()
//        logoView.contentMode = .scaleAspectFit
//        logoView.image = #imageLiteral(resourceName: "Transformers Logo")
//        logoView.tintColor = .gray
        navigationItem.titleView = logoView
        // Always display Large title in this View Controller
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        } else {
            // Fallback on earlier versions
        }
        navigationItem.leftBarButtonItem = battleButton
        navigationItem.rightBarButtonItem = createNewButton
        
        // Refresh control setup
        let refreshControl = UIRefreshControl()
        let title = "Pull to Refresh"
        refreshControl.attributedTitle = NSAttributedString(string: title)
        refreshControl.addTarget(self, action: #selector(refreshOptions(sender:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HomeTableViewCell

        // Configure the cell...

        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // iOS 11+
//    override func tableView(_ tableView: UITableView,
//                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
//    {
//        let remove = UIContextualAction(style: .normal, title:  "Remove", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
//            print("Remove button tapped at cell \(indexPath)")
//            success(true)
//        })
//        remove.backgroundColor = .red
//        return UISwipeActionsConfiguration(actions: [remove])
//    }
//
//    override func tableView(_ tableView: UITableView,
//                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
//    {
//
//        let edit = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
//            print("Edit button tapped at \(indexPath)")
//            success(true)
//        })
//        edit.backgroundColor = .gray
//        return UISwipeActionsConfiguration(actions: [edit])
//    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { [weak self] action, index in
            self?.handleEdit(indexPath: index)
        }
        edit.backgroundColor = .lightGray

        let remove = UITableViewRowAction(style: .normal, title: "Remove") { [weak self] action, index in
            self?.handleRemove(indexPath: index)
        }
        remove.backgroundColor = .red

        return [remove, edit]
    }


    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
