//
//  TableViewController.swift
//  Transformers
//
//  Created by Alexander Sundiev on 2019-10-07.
//  Copyright © 2019 Alexander Sundiev. All rights reserved.
//

import UIKit
import JGProgressHUD

protocol HomeTableViewControllerDelegate:class{
    func handleRefresh()
    func showHud()
    func hideHud()
}

class HomeTableViewController: UITableViewController, HomeTableViewControllerDelegate {
    
    // MARK: - Properties
    let cellId = "cellId"
    var transformers: Array<Transformer?> = []
    
    var response: [String: [Transformer?]] = ["": [nil]]

    // MARK: - Events
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: cellId)
        
        setupNavbar()
        
        // App First Launch
        if UserDefaults.standard.apiKey().isEmpty {
            ApiService.shared.authorize { (apiKey) in
                if !apiKey.isEmpty{
                    UserDefaults.standard.setApiKey(value: apiKey)
                    self.showHud()
                    self.handleRefresh()
                }
            }
        } else {
            showHud()
            handleRefresh()
        }
    }
    
    @objc private func refreshOptions(sender: UIRefreshControl){
        // Perform actions to refresh the content
        handleRefresh()
        // and then dismiss the control
        sender.endRefreshing()
    }
    
    // MARK: - UI Elements
    private let loadingHud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading…"
        hud.interactionType = .blockAllTouches
        hud.indicatorView = JGProgressHUDIndeterminateIndicatorView()
        return hud
    }()
    
    private let logoView: UIImageView = {
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
        createVC.delegate = self
        self.navigationController?.show(createVC, sender: self)
    }
    
    @objc func handleRefresh(){
        ApiService.shared.readAll { (response) in
            self.response = response
            self.transformers = response["transformers"] ?? []
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.hideHud()
            }
        }
        print("Refresh Initiated")
    }
    
    @objc func handleEdit(indexPath: IndexPath){
        print("Edit button tapped at cell \(indexPath)")
        showHud()
        let idToEdit = transformers[indexPath.row]?.id ?? ""
        ApiService.shared.read(transformerId: idToEdit) { (transformer) in
            self.hideHud()
            DispatchQueue.main.async {
                let editVC = EditTransformerViewController()
                editVC.transformerToUpdate = transformer
                editVC.editView.transformer = transformer
                editVC.editView.updateView()
                editVC.delegate = self
                self.navigationController?.show(editVC, sender: self)
            }
        }
    }
    
    @objc func handleRemove(indexPath: IndexPath){
        print("Remove button tapped at cell \(indexPath)")
        showHud()
        let cellToDelete = indexPath.row
        let idToDelete = transformers[cellToDelete]?.id ?? ""
        transformers.remove(at: cellToDelete)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        ApiService.shared.delete(transformerId: idToDelete){
            self.handleRefresh()
        }
    }
    // MARK: - Utility Methods
    func showHud(){
        loadingHud.show(in: self.view)
        DispatchQueue.main.async {
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }
    
    func hideHud(){
        loadingHud.dismiss()
        DispatchQueue.main.async {
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    // MARK: - View Setup
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
