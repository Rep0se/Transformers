//
//  EditTransformerViewController.swift
//  Transformers
//
//  Created by Alexander Sundiev on 2019-10-07.
//  Copyright © 2019 Alexander Sundiev. All rights reserved.
//

import UIKit

protocol EditTransformerViewControllerDelegate:class{
    func presentAlert(alert: UIAlertController, animated: Bool)
    func enableSaveButton()
    func disableSaveButton()
}

class EditTransformerViewController: UIViewController, EditTransformerViewControllerDelegate {
    
    // MARK: - Properties
    weak var delegate: HomeTableViewControllerDelegate?
    var transformerToUpdate: Transformer?
    
    // MARK: - Events
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        editView.transformer = transformerToUpdate
        setupNavbar()
        setupView()
    }
    
    // MARK: - UI Elements
    lazy var editView: EditTransformerView = {
        let view = EditTransformerView(frame: CGRect.zero)
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSave))
        button.isEnabled = false
        return button
    }()
    
    // MARK: - View Setup
    private func setupNavbar(){
        self.navigationController?.navigationBar.tintColor = .darkGray
        view.backgroundColor = .white
        // Always display Large title in this View Controller
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .always
        } else {
            // Fallback on earlier versions
        }
        navigationItem.title = "Create Transformer"
        navigationItem.rightBarButtonItem = saveButton
    }
    
    private func setupView(){
        view.addSubview(editView)
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                editView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                editView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                editView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                editView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
            ])
        } else {
            // Fallback on earlier versions
            NSLayoutConstraint.activate([
                editView.topAnchor.constraint(equalTo: view.topAnchor),
                editView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                editView.leftAnchor.constraint(equalTo: view.leftAnchor),
                editView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
        }
    }
    
    // MARK: - Handlers
    @objc private func handleSave(){
        let teamKey = editView.teamKey
        var team = "A"
        switch teamKey {
        case "Autobots":
            team = "A"
        case "Decepticons":
            team = "D"
        default:
            team = "A"
        }
        let id = transformerToUpdate?.id
        let name = editView.nameKey
        let techSpecs = editView.techSpecs
        let transformer = Transformer(id: id, name: name, team: team, strength: techSpecs[0], intelligence: techSpecs[1], speed: techSpecs[2], endurance: techSpecs[3], rank: techSpecs[4], courage: techSpecs[5], firepower: techSpecs[6], skill: techSpecs[7], team_icon: nil)
        delegate?.showHud()
        // Create or update based on the presence of transformerToUpdate
        if transformerToUpdate == nil{
            ApiService.shared.create(body: transformer) {
                self.delegate?.handleRefresh()
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        } else {
            ApiService.shared.update(body: transformer){
                self.delegate?.handleRefresh()
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
    }
    
    // MARK: - Delegate Methods
    func presentAlert(alert: UIAlertController, animated: Bool) {
        self.present(alert, animated: animated)
    }
    
    func enableSaveButton(){
        saveButton.isEnabled = true
    }
    
    func disableSaveButton(){
        saveButton.isEnabled = false
    }

}
