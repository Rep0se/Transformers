//
//  EditTransformerView.swift
//  Transformers
//
//  Created by Alexander Sundiev on 2019-10-07.
//  Copyright © 2019 Alexander Sundiev. All rights reserved.
//

import UIKit

class EditTransformerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views
    private let teamLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        textLabel.text = "Select your team:"
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
        imageView.tintColor = .gray
        return imageView
    }()
    
    private let teamLine: UIProgressView = {
        let line = UIProgressView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.progress = 1.0
        line.tintColor = .gray
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
        textLabel.text = "Select your name:"
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
        imageView.tintColor = .gray
        return imageView
    }()
    
    private let nameLine: UIProgressView = {
        let line = UIProgressView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.progress = 1.0
        line.tintColor = .gray
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
        textLabel.text = "Choose tech specs:"
        return textLabel
    }()
    
    //--
    
    private let strengthLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        textLabel.text = "Strength:"
        return textLabel
    }()
    
    private let strengthSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .gray
        return slider
    }()
    
    private let strengthValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = "55"
        return label
    }()
    
    private let intelligenceLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        textLabel.text = "Intelligence:"
        return textLabel
    }()
    
    private let intelligenceSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .gray
        return slider
    }()
    
    private let intelligenceValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = "55"
        return label
    }()
    
    private let speedLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        textLabel.text = "Speed:"
        return textLabel
    }()
    
    private let speedSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .gray
        return slider
    }()
    
    private let speedValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = "55"
        return label
    }()
    
    private let eduranceLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        textLabel.text = "Endurance:"
        return textLabel
    }()
    
    private let eduranceSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .gray
        return slider
    }()
    
    private let eduranceValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = "55"
        return label
    }()
    
    private let rankLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        textLabel.text = "Rank:"
        return textLabel
    }()
    
    private let rankSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .gray
        return slider
    }()
    
    private let rankValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = "55"
        return label
    }()
    
    private let courageLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        textLabel.text = "Courage:"
        return textLabel
    }()
    
    private let courageSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .gray
        return slider
    }()
    
    private let courageValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = "55"
        return label
    }()
    
    private let firepowerLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        textLabel.text = "Firepower:"
        return textLabel
    }()
    
    private let firepowerSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .gray
        return slider
    }()
    
    private let firepowerValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = "55"
        return label
    }()
    
    private let skillLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        textLabel.text = "Skill:"
        return textLabel
    }()
    
    private let skillSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .gray
        return slider
    }()
    
    private let skillValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = "55"
        return label
    }()
    
    //--
    
    private let overallRatingLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        textLabel.text = "Overall Rating:"
        return textLabel
    }()
    
    private let overallRatingValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = "55"
        return label
    }()
    
    // MARK: - Handlers
    @objc private func handleTeamSelection(){
        
    }
    
    @objc private func handleNameSelection(){
        
    }
    
    // MARK: - UI Layout
    private func setupLayout(){
        addSubview(teamLabel)
        addSubview(teamTextField)
        addSubview(teamChevronImage)
        addSubview(teamLine)
        addSubview(teamButton)
        
        addSubview(nameLabel)
        addSubview(nameTextField)
        addSubview(nameChevronImage)
        addSubview(nameLine)
        addSubview(nameButton)
        
        addSubview(techSpecsLabel)
        
        addSubview(strengthLabel)
        addSubview(strengthSlider)
        addSubview(strengthValueLabel)
        addSubview(intelligenceLabel)
        addSubview(intelligenceSlider)
        addSubview(intelligenceValueLabel)
        addSubview(speedLabel)
        addSubview(speedSlider)
        addSubview(speedValueLabel)
        addSubview(eduranceLabel)
        addSubview(eduranceSlider)
        addSubview(eduranceValueLabel)
        addSubview(rankLabel)
        addSubview(rankSlider)
        addSubview(rankValueLabel)
        addSubview(courageLabel)
        addSubview(courageSlider)
        addSubview(courageValueLabel)
        addSubview(firepowerLabel)
        addSubview(firepowerSlider)
        addSubview(firepowerValueLabel)
        addSubview(skillLabel)
        addSubview(skillSlider)
        addSubview(skillValueLabel)
        
        addSubview(overallRatingLabel)
        addSubview(overallRatingValueLabel)
        
        NSLayoutConstraint.activate([
            
            teamLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            teamLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            teamLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            teamLabel.heightAnchor.constraint(equalToConstant: 21),
            
            teamTextField.topAnchor.constraint(equalTo: teamLabel.bottomAnchor),
            teamTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            teamTextField.trailingAnchor.constraint(equalTo: teamChevronImage.leadingAnchor),
            teamTextField.heightAnchor.constraint(equalToConstant: 35),
            
            teamChevronImage.heightAnchor.constraint(equalToConstant: 30),
            teamChevronImage.widthAnchor.constraint(equalToConstant: 30),
            teamChevronImage.bottomAnchor.constraint(equalTo: teamTextField.bottomAnchor),
            teamChevronImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            teamLine.leadingAnchor.constraint(equalTo: teamTextField.leadingAnchor),
            teamLine.trailingAnchor.constraint(equalTo: teamTextField.trailingAnchor),
            teamLine.bottomAnchor.constraint(equalTo: teamTextField.bottomAnchor),
            
            teamButton.leadingAnchor.constraint(equalTo: teamTextField.leadingAnchor),
            teamButton.trailingAnchor.constraint(equalTo: teamTextField.trailingAnchor),
            teamButton.topAnchor.constraint(equalTo: teamTextField.topAnchor),
            teamButton.bottomAnchor.constraint(equalTo: teamTextField.bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: teamTextField.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            nameLabel.heightAnchor.constraint(equalToConstant: 21),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            nameTextField.trailingAnchor.constraint(equalTo: nameChevronImage.leadingAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 35),
            
            nameChevronImage.heightAnchor.constraint(equalToConstant: 30),
            nameChevronImage.widthAnchor.constraint(equalToConstant: 30),
            nameChevronImage.bottomAnchor.constraint(equalTo: nameTextField.bottomAnchor),
            nameChevronImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            nameLine.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            nameLine.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            nameLine.bottomAnchor.constraint(equalTo: nameTextField.bottomAnchor),
            
            nameButton.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            nameButton.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            nameButton.topAnchor.constraint(equalTo: nameTextField.topAnchor),
            nameButton.bottomAnchor.constraint(equalTo: nameTextField.bottomAnchor),
            
            techSpecsLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            techSpecsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            techSpecsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            techSpecsLabel.heightAnchor.constraint(equalToConstant: 21),
            
            
            strengthLabel.topAnchor.constraint(equalTo: techSpecsLabel.bottomAnchor, constant: 10),
            strengthLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            strengthLabel.heightAnchor.constraint(equalToConstant: 21),
            strengthLabel.widthAnchor.constraint(equalToConstant: 90),
            
            strengthSlider.topAnchor.constraint(equalTo: strengthLabel.topAnchor),
            strengthSlider.bottomAnchor.constraint(equalTo: strengthLabel.bottomAnchor),
            strengthSlider.leadingAnchor.constraint(equalTo: strengthLabel.trailingAnchor, constant: 8),
            strengthSlider.trailingAnchor.constraint(equalTo: strengthValueLabel.leadingAnchor, constant: -16),
            
            strengthValueLabel.topAnchor.constraint(equalTo: strengthLabel.topAnchor),
            strengthValueLabel.bottomAnchor.constraint(equalTo: strengthLabel.bottomAnchor),
            strengthValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            strengthValueLabel.widthAnchor.constraint(equalToConstant: 21),
            
            
            intelligenceLabel.topAnchor.constraint(equalTo: strengthLabel.bottomAnchor, constant: 10),
            intelligenceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            intelligenceLabel.heightAnchor.constraint(equalToConstant: 21),
            intelligenceLabel.widthAnchor.constraint(equalToConstant: 90),

            intelligenceSlider.topAnchor.constraint(equalTo: intelligenceLabel.topAnchor),
            intelligenceSlider.bottomAnchor.constraint(equalTo: intelligenceLabel.bottomAnchor),
            intelligenceSlider.leadingAnchor.constraint(equalTo: intelligenceLabel.trailingAnchor, constant: 8),
            intelligenceSlider.trailingAnchor.constraint(equalTo: intelligenceValueLabel.leadingAnchor, constant: -16),

            intelligenceValueLabel.topAnchor.constraint(equalTo: intelligenceLabel.topAnchor),
            intelligenceValueLabel.bottomAnchor.constraint(equalTo: intelligenceLabel.bottomAnchor),
            intelligenceValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            intelligenceValueLabel.widthAnchor.constraint(equalToConstant: 21),
            
            
            speedLabel.topAnchor.constraint(equalTo: intelligenceLabel.bottomAnchor, constant: 10),
            speedLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            speedLabel.heightAnchor.constraint(equalToConstant: 21),
            speedLabel.widthAnchor.constraint(equalToConstant: 90),

            speedSlider.topAnchor.constraint(equalTo: speedLabel.topAnchor),
            speedSlider.bottomAnchor.constraint(equalTo: speedLabel.bottomAnchor),
            speedSlider.leadingAnchor.constraint(equalTo: speedLabel.trailingAnchor, constant: 8),
            speedSlider.trailingAnchor.constraint(equalTo: speedValueLabel.leadingAnchor, constant: -16),

            speedValueLabel.topAnchor.constraint(equalTo: speedLabel.topAnchor),
            speedValueLabel.bottomAnchor.constraint(equalTo: speedLabel.bottomAnchor),
            speedValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            speedValueLabel.widthAnchor.constraint(equalToConstant: 21),
            

            eduranceLabel.topAnchor.constraint(equalTo: speedLabel.bottomAnchor, constant: 10),
            eduranceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            eduranceLabel.heightAnchor.constraint(equalToConstant: 21),
            eduranceLabel.widthAnchor.constraint(equalToConstant: 90),

            eduranceSlider.topAnchor.constraint(equalTo: eduranceLabel.topAnchor),
            eduranceSlider.bottomAnchor.constraint(equalTo: eduranceLabel.bottomAnchor),
            eduranceSlider.leadingAnchor.constraint(equalTo: eduranceLabel.trailingAnchor, constant: 8),
            eduranceSlider.trailingAnchor.constraint(equalTo: eduranceValueLabel.leadingAnchor, constant: -16),

            eduranceValueLabel.topAnchor.constraint(equalTo: eduranceLabel.topAnchor),
            eduranceValueLabel.bottomAnchor.constraint(equalTo: eduranceLabel.bottomAnchor),
            eduranceValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            eduranceValueLabel.widthAnchor.constraint(equalToConstant: 21),


            rankLabel.topAnchor.constraint(equalTo: eduranceLabel.bottomAnchor, constant: 10),
            rankLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            rankLabel.heightAnchor.constraint(equalToConstant: 21),
            rankLabel.widthAnchor.constraint(equalToConstant: 90),

            rankSlider.topAnchor.constraint(equalTo: rankLabel.topAnchor),
            rankSlider.bottomAnchor.constraint(equalTo: rankLabel.bottomAnchor),
            rankSlider.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: 8),
            rankSlider.trailingAnchor.constraint(equalTo: rankValueLabel.leadingAnchor, constant: -16),

            rankValueLabel.topAnchor.constraint(equalTo: rankLabel.topAnchor),
            rankValueLabel.bottomAnchor.constraint(equalTo: rankLabel.bottomAnchor),
            rankValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            rankValueLabel.widthAnchor.constraint(equalToConstant: 21),


            courageLabel.topAnchor.constraint(equalTo: rankLabel.bottomAnchor, constant: 10),
            courageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            courageLabel.heightAnchor.constraint(equalToConstant: 21),
            courageLabel.widthAnchor.constraint(equalToConstant: 90),

            courageSlider.topAnchor.constraint(equalTo: courageLabel.topAnchor),
            courageSlider.bottomAnchor.constraint(equalTo: courageLabel.bottomAnchor),
            courageSlider.leadingAnchor.constraint(equalTo: courageLabel.trailingAnchor, constant: 8),
            courageSlider.trailingAnchor.constraint(equalTo: courageValueLabel.leadingAnchor, constant: -16),

            courageValueLabel.topAnchor.constraint(equalTo: courageLabel.topAnchor),
            courageValueLabel.bottomAnchor.constraint(equalTo: courageLabel.bottomAnchor),
            courageValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            courageValueLabel.widthAnchor.constraint(equalToConstant: 21),


            firepowerLabel.topAnchor.constraint(equalTo: courageLabel.bottomAnchor, constant: 10),
            firepowerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            firepowerLabel.heightAnchor.constraint(equalToConstant: 21),
            firepowerLabel.widthAnchor.constraint(equalToConstant: 90),

            firepowerSlider.topAnchor.constraint(equalTo: firepowerLabel.topAnchor),
            firepowerSlider.bottomAnchor.constraint(equalTo: firepowerLabel.bottomAnchor),
            firepowerSlider.leadingAnchor.constraint(equalTo: firepowerLabel.trailingAnchor, constant: 8),
            firepowerSlider.trailingAnchor.constraint(equalTo: firepowerValueLabel.leadingAnchor, constant: -16),

            firepowerValueLabel.topAnchor.constraint(equalTo: firepowerLabel.topAnchor),
            firepowerValueLabel.bottomAnchor.constraint(equalTo: firepowerLabel.bottomAnchor),
            firepowerValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            firepowerValueLabel.widthAnchor.constraint(equalToConstant: 21),


            skillLabel.topAnchor.constraint(equalTo: firepowerLabel.bottomAnchor, constant: 10),
            skillLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            skillLabel.heightAnchor.constraint(equalToConstant: 21),
            skillLabel.widthAnchor.constraint(equalToConstant: 90),

            skillSlider.topAnchor.constraint(equalTo: skillLabel.topAnchor),
            skillSlider.bottomAnchor.constraint(equalTo: skillLabel.bottomAnchor),
            skillSlider.leadingAnchor.constraint(equalTo: skillLabel.trailingAnchor, constant: 8),
            skillSlider.trailingAnchor.constraint(equalTo: skillValueLabel.leadingAnchor, constant: -16),

            skillValueLabel.topAnchor.constraint(equalTo: skillLabel.topAnchor),
            skillValueLabel.bottomAnchor.constraint(equalTo: skillLabel.bottomAnchor),
            skillValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            skillValueLabel.widthAnchor.constraint(equalToConstant: 21),
            
            
            overallRatingLabel.topAnchor.constraint(equalTo: skillLabel.bottomAnchor, constant: 14),
            overallRatingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            overallRatingLabel.heightAnchor.constraint(equalToConstant: 21),
            overallRatingLabel.widthAnchor.constraint(equalToConstant: 120),
            
            overallRatingValueLabel.topAnchor.constraint(equalTo: overallRatingLabel.topAnchor),
            overallRatingValueLabel.bottomAnchor.constraint(equalTo: overallRatingLabel.bottomAnchor),
            overallRatingValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            overallRatingValueLabel.widthAnchor.constraint(equalToConstant: 21),
        ])
        
    }

}
