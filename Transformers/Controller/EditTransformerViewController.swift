//
//  EditTransformerViewController.swift
//  Transformers
//
//  Created by Alexander Sundiev on 2019-10-07.
//  Copyright © 2019 Alexander Sundiev. All rights reserved.
//

import UIKit

class EditTransformerViewController: UIViewController {

    
    // MARK: - Events
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupNavbar()
    }
    
    // MARK: - Views
    private let teamLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return textLabel
    }()
    
    private let teamTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textField.textColor = .white
        return textField
    }()
    
    private let teamChevronImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "round_arrow_drop_down_black_24pt")
        return imageView
    }()
    
    private let teamLine: UIProgressView = {
        let line = UIProgressView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.progress = 1.0
        return line
    }()
    
    lazy var teamButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleTeamSelection), for: .touchUpInside)
        return button
    }()
    
    //--
    
    private let nameLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return textLabel
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textField.textColor = .white
        return textField
    }()
    
    private let nameChevronImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "round_arrow_drop_down_black_24pt")
        return imageView
    }()
    
    private let nameLine: UIProgressView = {
        let line = UIProgressView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.progress = 1.0
        return line
    }()
    
    lazy var nameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleNameSelection), for: .touchUpInside)
        return button
    }()
    
    //--
    
    private let techSpecsLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return textLabel
    }()
    
    
    // MARK: - View Setup
    private func setupNavbar(){
        self.navigationController?.navigationBar.tintColor = .gray
        // Always display Large title in this View Controller
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .always
        } else {
            // Fallback on earlier versions
        }
        navigationItem.title = "Create Transformer"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSave))
    }
    
    // MARK: - Handlers
    @objc private func handleTeamSelection(){
        
    }
    
    @objc private func handleNameSelection(){
        
    }
    
    
    
    @objc private func handleSave(){
        
    }

}
