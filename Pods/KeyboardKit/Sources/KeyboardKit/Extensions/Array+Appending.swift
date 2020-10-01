//
//  Array+Appending.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-05.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Array {
    
    /**
     Creates a copy of the array and appends the new element
     to the end of the copy.
     */
    func appending(_ newElement: Element) -> Array {
        var result = Array(self)
        result.append(newElement)
        return result
    }
}
