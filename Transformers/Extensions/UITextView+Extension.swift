//
//  UITextView+Extension.swift
//  Transformers
//
//  Created by Alexander Sundiev on 2019-10-07.
//  Copyright © 2019 Alexander Sundiev. All rights reserved.
//

import UIKit

extension UITextView {
    
    /**
     This function creates attributedText from four Strings in UITextView and aligns them to proper side.
     - Parameter to: Alignemnt options: .left .right or .center.
     - Parameter row1: First String.
     - Parameter row2: Second String.
     - Parameter row3: Third String.
     - Parameter row4: Fourth String.
     */
    func alignAttributedText(to alignment: NSTextAlignment, withFontWeight weight: UIFont.Weight, row1: String, row2: String, row3: String, row4: String){
        text = "\(row1)\n\(row2)\n\(row3)\n\(row4)"
        font = UIFont.systemFont(ofSize: 14, weight: weight)
        textAlignment = alignment
    }
    
}
