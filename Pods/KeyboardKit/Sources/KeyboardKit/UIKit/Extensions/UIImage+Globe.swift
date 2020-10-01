//
//  UIImage+Globe.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-11.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
public extension UIImage {
    
    /**
     The globe icon that is used for "next keyboard" buttons.
     
     You can vary `pointSize` to fit the use-case, then vary
     `weight` and `scale` to customize it further.
     */
    static func globe(
        pointSize: CGFloat,
        weight: SymbolWeight = .light,
        scale: SymbolScale = .medium) -> UIImage? {
        UIImage(systemName: "globe", withConfiguration: SymbolConfiguration(
            pointSize: pointSize,
            weight: weight,
            scale: scale))?.withRenderingMode(.alwaysTemplate)
    }
}
