//
//  EditTransformerView.swift
//  Transformers
//
//  Created by Alexander Sundiev on 2019-10-07.
//  Copyright © 2019 Alexander Sundiev. All rights reserved.
//

import UIKit

class EditTransformerView: UIView {
    
    // MARK: - Properties
    weak var delegate: EditTransformerViewControllerDelegate?
    var teamKey = ""
    var nameKey = ""
    var techSpecs = [Int](repeating: 5, count: 8)
    var transformer: Transformer?
    
    // MARK: - Initializers
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
    
    lazy var strengthSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .gray
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.setValue(Float(techSpecs[0]), animated: true)
        slider.addTarget(self, action: #selector(strengthSliderValueDidChange(_:)), for: .valueChanged)
        return slider
    }()
    
    private let strengthValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = "5"
        return label
    }()
    
    private let intelligenceLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        textLabel.text = "Intelligence:"
        return textLabel
    }()
    
    lazy var intelligenceSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .gray
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.setValue(Float(techSpecs[1]), animated: true)
        slider.addTarget(self, action: #selector(intelligenceSliderValueDidChange(_:)), for: .valueChanged)
        return slider
    }()
    
    private let intelligenceValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = "5"
        return label
    }()
    
    private let speedLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        textLabel.text = "Speed:"
        return textLabel
    }()
    
    lazy var speedSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .gray
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.setValue(Float(techSpecs[2]), animated: true)
        slider.addTarget(self, action: #selector(speedSliderValueDidChange(_:)), for: .valueChanged)
        return slider
    }()
    
    private let speedValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = "5"
        return label
    }()
    
    private let eduranceLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        textLabel.text = "Endurance:"
        return textLabel
    }()
    
    lazy var enduranceSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .gray
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.setValue(Float(techSpecs[3]), animated: true)
        slider.addTarget(self, action: #selector(eduranceSliderValueDidChange(_:)), for: .valueChanged)
        return slider
    }()
    
    private let eduranceValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = "5"
        return label
    }()
    
    private let rankLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        textLabel.text = "Rank:"
        return textLabel
    }()
    
    lazy var rankSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .gray
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.setValue(Float(techSpecs[4]), animated: true)
        slider.addTarget(self, action: #selector(rankSliderValueDidChange(_:)), for: .valueChanged)
        return slider
    }()
    
    private let rankValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = "5"
        return label
    }()
    
    private let courageLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        textLabel.text = "Courage:"
        return textLabel
    }()
    
    lazy var courageSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .gray
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.setValue(Float(techSpecs[5]), animated: true)
        slider.addTarget(self, action: #selector(courageSliderValueDidChange(_:)), for: .valueChanged)
        return slider
    }()
    
    private let courageValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = "5"
        return label
    }()
    
    private let firepowerLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        textLabel.text = "Firepower:"
        return textLabel
    }()
    
    lazy var firepowerSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .gray
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.setValue(Float(techSpecs[6]), animated: true)
        slider.addTarget(self, action: #selector(firepowerSliderValueDidChange(_:)), for: .valueChanged)
        return slider
    }()
    
    private let firepowerValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = "5"
        return label
    }()
    
    private let skillLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        textLabel.text = "Skill:"
        return textLabel
    }()
    
    lazy var skillSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .gray
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.setValue(Float(techSpecs[7]), animated: true)
        slider.addTarget(self, action: #selector(skillSliderValueDidChange(_:)), for: .valueChanged)
        return slider
    }()
    
    private let skillValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = "5"
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
        label.text = "30"
        return label
    }()
    
    // MARK: - Handlers
    @objc private func handleTeamSelection(){
        let alert = UIAlertController(title: "Select your team:", message: nil, preferredStyle: .actionSheet)
        let optionsList = ["Autobots", "Decepticons"]
        for key in optionsList {
            let action = UIAlertAction(title: key, style: .default) { [weak self] action in
                self?.teamKey = key
                self?.teamTextField.text = key
                self?.nameTextField.text = ""
                self?.checkCompletion()
                alert.dismiss(animated: true)
            }
            alert.addAction(action)
        }
        let close = UIAlertAction(title: "Close", style: .cancel) { action in
            alert.dismiss(animated: true)
        }
        alert.addAction(close)
        alert.modalPresentationStyle = .popover
        // iPad presentation
        let popPresenter: UIPopoverPresentationController? = alert.popoverPresentationController
        popPresenter?.sourceView = teamButton
        popPresenter?.sourceRect = teamButton.bounds
        alert.view.tintColor = .darkGray
        delegate?.presentAlert(alert: alert, animated: true)
    }
    
    @objc private func handleNameSelection(){
        let alert = UIAlertController(title:  "Select your name:", message: nil, preferredStyle: .actionSheet)
        let autobotNames = ["Afterburner", "Air Raid", "Beachcomber", "Blades", "Blaster", "Bluestreak", "Blurr", "Brainstorm", "Brawn", "Broadside", "Bumblebee", "Chase", "Chromedome", "Cliffjumper", "Cloudraker", "Computron", "Cosmos", "Crosshairs", "Defensor", "Doublecross", "Eject", "Fastlane", "Fireflight", "First Aid", "Fortress Maximus", "Freeway", "Gears", "Goldbug", "Grapple", "Grimlock", "Groove", "Grotusque", "Hardhead", "Highbrow", "Hoist", "Hot Rod", "Hot Spot", "Hound", "Hubcap", "Huffer", "Inferno", "Ironhide", "Jazz", "Jetfire", "Kup", "Lightspeed", "Metroplex", "Mirage", "Nosecone", "Omega Supreme", "Optimus Prime", "Outback", "Perceptor", "Pipes", "Pointblank", "Powerglide", "Prowl", "Punch", "Ramhorn", "Ratchet", "Red Alert", "Repugnus", "Rewind", "Roadbuster", "Rodimus Prime", "Rollbar", "Sandstorm", "Scattershot", "Searchlight", "Seaspray", "Sideswipe", "Silverbolt", "Siren", "Skids", "Skydive", "Sky Lynx", "Slag", "Slingshot", "Sludge", "Smokescreen", "Snarl", "Springer", "Steeljaw", "Strafe", "Streetwise", "Sunstreaker", "Superion", "Sureshot", "Swerve", "Swoop", "Tailgate", "Topspin", "Tracks", "Trailbreaker", "Twin Twist", "Ultra Magnus", "Warpath", "Wheelie", "Wheeljack", "Whirl", "Wideload", "Windcharger", "Wreck-Gar"]
        let decepticonNames = ["Abominus", "Apeface", "Astrotrain", "Barrage", "Battletrap", "Blast Off", "Blitzwing", "Blot", "Bombshell", "Bonecrusher", "Brawl", "Breakdown", "Bruticus", "Buzzsaw", "Chop Shop", "Counterpunch", "Cutthroat", "Cyclonus", "Dead End", "Devastator", "Dirge", "Divebomb", "Drag Strip", "Fangry", "Flywheels", "Frenzy", "Galvatron", "Gnaw", "Headstrong", "Hook", "Hun-Grrr", "Kickback", "Laserbeak", "Long Haul", "Megatron", "Menasor", "Mindwipe", "Misfire", "Mixmaster", "Motormaster", "Octane", "Onslaught", "Overkill", "Pounce", "Predaking", "Ramjet", "Rampage", "Ransack", "Ratbat", "Ravage", "Razorclaw", "Reflector", "Rippersnapper", "Rumble", "Runabout", "Runamuck", "Scavenger", "Scorponok", "Scourge", "Scrapper", "Shockwave", "Shrapnel", "Sinnertwin", "Sixshot", "Skullcruncher", "Skywarp", "Slugfest", "Slugslinger", "Snapdragon", "Soundwave", "Starscream", "Swindle", "Tantrum", "Thrust", "Thundercracker", "Triggerhappy", "Trypticon", "Venom", "Vortex", "Weirdwolf", "Wildrider", "Wingspan"]
        var optionsList: Array<String> = []
        if teamTextField.text == "Autobots" {
            optionsList = autobotNames
        } else if teamTextField.text == "Decepticons" {
            optionsList = decepticonNames
        } else {
            nameTextField.text = "Please select the team first"
            return
        }
        
        for key in optionsList {
            let action = UIAlertAction(title: key, style: .default) { [weak self] action in
                self?.nameKey = key
                self?.nameTextField.text = key
                self?.checkCompletion()
                alert.dismiss(animated: true)
            }
            alert.addAction(action)
        }
        let close = UIAlertAction(title: "Close", style: .cancel) { action in
            alert.dismiss(animated: true)
        }
        alert.addAction(close)
        alert.modalPresentationStyle = .popover
        // iPad presentation
        let popPresenter: UIPopoverPresentationController? = alert.popoverPresentationController
        popPresenter?.sourceView = nameButton
        popPresenter?.sourceRect = nameButton.bounds
        alert.view.tintColor = .darkGray
        delegate?.presentAlert(alert: alert, animated: true)

    }
    
    @objc private func strengthSliderValueDidChange(_ sender: UISlider!){
        // Snaps slider to values
        let roundedStepValue = round(sender.value)
        sender.value = roundedStepValue
        techSpecs[0] = Int(roundedStepValue)
        strengthValueLabel.text = String(Int(roundedStepValue))
        overallRatingValueLabel.text = String(techSpecs[0] + techSpecs[1] + techSpecs[2] + techSpecs[3] + techSpecs[6])
        checkCompletion()
    }
    
    @objc private func intelligenceSliderValueDidChange(_ sender: UISlider!){
        // Snaps slider to values
        let roundedStepValue = round(sender.value)
        sender.value = roundedStepValue
        techSpecs[1] = Int(roundedStepValue)
        intelligenceValueLabel.text = String(Int(roundedStepValue))
        overallRatingValueLabel.text = String(techSpecs[0] + techSpecs[1] + techSpecs[2] + techSpecs[3] + techSpecs[6])
        checkCompletion()
    }
    
    @objc private func speedSliderValueDidChange(_ sender: UISlider!){
        // Snaps slider to values
        let roundedStepValue = round(sender.value)
        sender.value = roundedStepValue
        techSpecs[2] = Int(roundedStepValue)
        speedValueLabel.text = String(Int(roundedStepValue))
        overallRatingValueLabel.text = String(techSpecs[0] + techSpecs[1] + techSpecs[2] + techSpecs[3] + techSpecs[6])
        checkCompletion()
    }
    
    @objc private func eduranceSliderValueDidChange(_ sender: UISlider!){
        // Snaps slider to values
        let roundedStepValue = round(sender.value)
        sender.value = roundedStepValue
        techSpecs[3] = Int(roundedStepValue)
        eduranceValueLabel.text = String(Int(roundedStepValue))
        overallRatingValueLabel.text = String(techSpecs[0] + techSpecs[1] + techSpecs[2] + techSpecs[3] + techSpecs[6])
        checkCompletion()
    }
    
    @objc private func rankSliderValueDidChange(_ sender: UISlider!){
        // Snaps slider to values
        let roundedStepValue = round(sender.value)
        sender.value = roundedStepValue
        techSpecs[4] = Int(roundedStepValue)
        rankValueLabel.text = String(Int(roundedStepValue))
        overallRatingValueLabel.text = String(techSpecs[0] + techSpecs[1] + techSpecs[2] + techSpecs[3] + techSpecs[6])
        checkCompletion()
    }
    
    @objc private func courageSliderValueDidChange(_ sender: UISlider!){
        // Snaps slider to values
        let roundedStepValue = round(sender.value)
        sender.value = roundedStepValue
        techSpecs[5] = Int(roundedStepValue)
        courageValueLabel.text = String(Int(roundedStepValue))
        overallRatingValueLabel.text = String(techSpecs[0] + techSpecs[1] + techSpecs[2] + techSpecs[3] + techSpecs[6])
        checkCompletion()
    }
    
    @objc private func firepowerSliderValueDidChange(_ sender: UISlider!){
        // Snaps slider to values
        let roundedStepValue = round(sender.value)
        sender.value = roundedStepValue
        techSpecs[6] = Int(roundedStepValue)
        firepowerValueLabel.text = String(Int(roundedStepValue))
        overallRatingValueLabel.text = String(techSpecs[0] + techSpecs[1] + techSpecs[2] + techSpecs[3] + techSpecs[6])
        checkCompletion()
    }
    
    @objc private func skillSliderValueDidChange(_ sender: UISlider!){
        // Snaps slider to values
        let roundedStepValue = round(sender.value)
        sender.value = roundedStepValue
        techSpecs[7] = Int(roundedStepValue)
        skillValueLabel.text = String(Int(roundedStepValue))
        overallRatingValueLabel.text = String(techSpecs[0] + techSpecs[1] + techSpecs[2] + techSpecs[3] + techSpecs[6])
        checkCompletion()
    }
    
    private func checkCompletion(){
        let pageComplete = !(teamTextField.text?.isEmpty ?? true) && !(nameTextField.text?.isEmpty ?? true)
        
        if pageComplete {
            // Delegate -> Show/Hide Save button on VC
            delegate?.enableSaveButton()
        } else {
            delegate?.disableSaveButton()
        }
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
        addSubview(enduranceSlider)
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
            teamButton.trailingAnchor.constraint(equalTo: teamChevronImage.trailingAnchor),
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
            nameButton.trailingAnchor.constraint(equalTo: nameChevronImage.trailingAnchor),
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

            enduranceSlider.topAnchor.constraint(equalTo: eduranceLabel.topAnchor),
            enduranceSlider.bottomAnchor.constraint(equalTo: eduranceLabel.bottomAnchor),
            enduranceSlider.leadingAnchor.constraint(equalTo: eduranceLabel.trailingAnchor, constant: 8),
            enduranceSlider.trailingAnchor.constraint(equalTo: eduranceValueLabel.leadingAnchor, constant: -16),

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
    
    func updateView(){
        if let transformer = transformer {
            var team = ""
            switch transformer.team{
            case "A":
                team = "Autobots"
            case "D":
                team = "Decepticons"
            default:
                team = "Unknown"
            }
            let (
                strength,
                intelligence,
                speed,
                endurance,
                rank,
                courage,
                firepower,
                skill
            ) = (
                transformer.strength ?? 5,
                transformer.intelligence ?? 5,
                transformer.speed ?? 5,
                transformer.endurance ?? 5,
                transformer.rank ?? 5,
                transformer.courage ?? 5,
                transformer.firepower ?? 5,
                transformer.skill ?? 5
            )
            
            teamTextField.text = team
            teamKey = team
            nameTextField.text = transformer.name
            nameKey = transformer.name ?? ""
            strengthSlider.setValue(Float(strength), animated: true)
            intelligenceSlider.setValue(Float(intelligence), animated: true)
            speedSlider.setValue(Float(speed), animated: true)
            enduranceSlider.setValue(Float(endurance), animated: true)
            rankSlider.setValue(Float(rank), animated: true)
            courageSlider.setValue(Float(courage), animated: true)
            firepowerSlider.setValue(Float(firepower), animated: true)
            skillSlider.setValue(Float(skill), animated: true)
            overallRatingValueLabel.text = String(strength + intelligence + speed + endurance + firepower)
        }
    }

}
