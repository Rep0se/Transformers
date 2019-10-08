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
}

class EditTransformerViewController: UIViewController, EditTransformerViewControllerDelegate {

    
    // MARK: - Events
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavbar()
        setupView()
    }
    
    // MARK: - UI Elements
    lazy var editView: UIView = {
        let view = EditTransformerView(frame: CGRect.zero)
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSave))
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
        
    }
    
    func presentAlert(alert: UIAlertController, animated: Bool) {
        self.present(alert, animated: animated)
    }

}
