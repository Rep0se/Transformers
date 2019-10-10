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
    var transformers: Array<Transformer> = []

    // MARK: - Events
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let testformer = Transformer(id: "-LqmXIL_IhwF4Obb8oWg", name: "Deceptitest", team: "D", strength: 1, intelligence: 1, speed: 1, endurance: 1, rank: 1, courage: 1, firepower: 1, skill: 1, team_icon: nil)
//        _ = ApiService.shared.create(body: testformer)
        
//        _ = ApiService.shared.readAll()
        
        //  -LqmRUkPN0-SnadIEv_t
        //  -LqmTjbPEtJk6ELqAqTq
        //
        
//        _ = ApiService.shared.read(transformerId: "")
        
//        _ = ApiService.shared.update(body: testformer)
        
//        _ = ApiService.shared.delete(transformerId: "-LqmRUkPN0-SnadIEv_t")
        _ = ApiService.shared.readAll()
        
//        let key = ApiService.shared.authorize()
//        print("---> \(String(describing: key))")
        
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
        imageView.tintColor = .darkGray
        return imageView
    }()
    
    lazy var battleButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Battle Icon"), style: .plain, target: self, action: #selector(handleBattle))
        barButton.tintColor = .darkGray
        return barButton
    }()
    
    lazy var createNewButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: #imageLiteral(resourceName: "round_add_black_24pt"), style: .plain, target: self, action: #selector(handleCreateNew))
        barButton.tintColor = .darkGray
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
        navigationItem.titleView = logoView
        navigationController?.navigationBar.tintColor = .darkGray
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return transformers.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HomeTableViewCell
        let transformer = transformers[indexPath.row]
        cell.cell = transformer
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
    }

}
