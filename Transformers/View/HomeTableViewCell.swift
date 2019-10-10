//
//  TableViewCell.swift
//  Transformers
//
//  Created by Alexander Sundiev on 2019-10-07.
//  Copyright © 2019 Alexander Sundiev. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    var cell: Transformer? {
        didSet{
            guard let unwrappedCell = cell else { return }
            // Profile Image
            switch unwrappedCell.team {
            case "A":
                profileImageView.image = #imageLiteral(resourceName: "autobot logo")
            case "D":
                profileImageView.image = #imageLiteral(resourceName: "decepticons logo")
            default:
                return
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
                unwrappedCell.strength ?? 5,
                unwrappedCell.intelligence ?? 5,
                unwrappedCell.speed ?? 5,
                unwrappedCell.endurance ?? 5,
                unwrappedCell.rank ?? 5,
                unwrappedCell.courage ?? 5,
                unwrappedCell.firepower ?? 5,
                unwrappedCell.skill ?? 5
            )
            
            // Transformer Details & Specs
            titleLabel.text = unwrappedCell.name
            siseValuesTextView.alignAttributedText(
                to: .right,
                withFontWeight: .bold,
                row1: String(strength),
                row2: String(intelligence),
                row3: String(speed),
                row4: String(endurance)
            )
            rcfsValuesTextView.alignAttributedText(
                to: .right,
                withFontWeight: .bold,
                row1: String(rank),
                row2: String(courage),
                row3: String(firepower),
                row4: String(skill)
            )
            ratingLabel.text = String(strength + intelligence + speed + endurance + firepower)
        }
    }
    
    // MARK: - UI Objects
    private let headerContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Transformer Name"
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "99"
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let bodyContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "autobot logo")
        imageView.tintColor = .black
        imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let siseTitlesTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.isSelectable = false
        textView.alignAttributedText(to: .left, withFontWeight: .bold, row1: "Strength:", row2: "Intelligence:", row3: "Speed:", row4: "Endurance:")
        return textView
    }()
    
    private let siseValuesTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.isSelectable = false
        textView.alignAttributedText(to: .right, withFontWeight: .regular, row1: "5", row2: "5", row3: "5", row4: "5")
        return textView
    }()
    
    private let rcfsTitlesTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.isSelectable = false
        textView.alignAttributedText(to: .left, withFontWeight: .bold, row1: "Rank:", row2: "Courage:", row3: "Firepower:", row4: "Skill:")
        return textView
    }()
    
    private let rcfsValuesTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.isSelectable = false
        textView.alignAttributedText(to: .right, withFontWeight: .regular, row1: "5", row2: "5", row3: "5", row4: "5")
        return textView
    }()

    
    // MARK: - Layout
    private func setupLayout(){
        contentView.addSubview(headerContainerView)
        headerContainerView.addSubview(titleLabel)
        headerContainerView.addSubview(ratingLabel)
        
        contentView.addSubview(bodyContainerView)
        bodyContainerView.addSubview(profileImageView)
        bodyContainerView.addSubview(siseTitlesTextView)
        bodyContainerView.addSubview(siseValuesTextView)
        bodyContainerView.addSubview(rcfsTitlesTextView)
        bodyContainerView.addSubview(rcfsValuesTextView)
        
        headerContainerView.anchorWithConstantsTo(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: bodyContainerView.topAnchor, right: contentView.rightAnchor, topPadding: 0, leftPadding: 0, bottomPadding: 0, rightPadding: 0)
        titleLabel.anchorWithConstantsTo(top: headerContainerView.topAnchor, left: headerContainerView.leftAnchor, bottom: nil, right: nil, topPadding: 8, leftPadding: 16, bottomPadding: 0, rightPadding: 0)
        ratingLabel.anchorWithConstantsTo(top: headerContainerView.topAnchor, left: nil, bottom: nil, right: headerContainerView.rightAnchor, topPadding: 8, leftPadding: 0, bottomPadding: 0, rightPadding: 16)
        
        
        bodyContainerView.anchorWithConstantsTo(top: headerContainerView.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, topPadding: 8, leftPadding: 0, bottomPadding: 4, rightPadding: 0)
        profileImageView.anchorWithConstantsTo(top: bodyContainerView.topAnchor, left: bodyContainerView.leftAnchor, bottom: bodyContainerView.bottomAnchor, right: nil, topPadding: 16, leftPadding: 16, bottomPadding: 16, rightPadding: 0)
        siseTitlesTextView.anchorWithConstantsTo(top: bodyContainerView.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, topPadding: 8, leftPadding: 4, bottomPadding: 0, rightPadding: 0)
        siseValuesTextView.anchorWithConstantsTo(top: bodyContainerView.topAnchor, left: siseTitlesTextView.rightAnchor, bottom: nil, right: nil, topPadding: 8, leftPadding: 0, bottomPadding: 0, rightPadding: 0)
        rcfsTitlesTextView.anchorWithConstantsTo(top: bodyContainerView.topAnchor, left: siseValuesTextView.rightAnchor, bottom: nil, right: nil, topPadding: 8, leftPadding: 4, bottomPadding: 0, rightPadding: 0)
        rcfsValuesTextView.anchorWithConstantsTo(top: bodyContainerView.topAnchor, left: rcfsTitlesTextView.rightAnchor, bottom: nil, right: nil, topPadding: 8, leftPadding: 0, bottomPadding: 0, rightPadding: 0)
        
        
        NSLayoutConstraint.activate([
            headerContainerView.heightAnchor.constraint(equalToConstant: 32),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),
            
        ])
        
    }
    
    // MARK: - Methods
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
