//
//  Array+Extension.swift
//  Transformers
//
//  Created by Alexander Sundiev on 2019-10-11.
//  Copyright © 2019 Alexander Sundiev. All rights reserved.
//

import Foundation
extension Array where Element: Equatable {
    func indexes(of element: Element) -> [Int] {
        return self.enumerated().filter({ element == $0.element }).map({ $0.offset })
    }
}
