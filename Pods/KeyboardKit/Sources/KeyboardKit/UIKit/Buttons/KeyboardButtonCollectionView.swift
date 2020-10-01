//
//  KeyboardButtonCollectionView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-02.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This collection view displays a single cell for each action.
 You can customize it and its appearance in any way you want,
 e.g. by setting a custom flow layout.
 
 This view can be created with a set of actions and a button
 creator, which creates a button for each action and adds it
 to the dequeued cell.
 
 Note that the class aims at simplifying creating collection
 based keyboards, but does so with a performance cost. It is
 less performant than `KeyboardCollectionView` since it only
 reuses the cells, but recreates the buttons every time.
 */
open class KeyboardButtonCollectionView: KeyboardCollectionView {
    
    
    // MARK: - Initialization
    
    public init(actions: [KeyboardAction], buttonCreator: @escaping KeyboardButtonCreator) {
        self.buttonCreator = buttonCreator
        super.init(actions: actions)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.buttonCreator = { _ in fatalError() }
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Types
    
    public typealias KeyboardButtonCreator = (KeyboardAction) -> (UIView)
    
    
    // MARK: - Properties
    
    private let buttonCreator: KeyboardButtonCreator
    
    
    // MARK: - UICollectionViewDataSource
    
    open func action(at indexPath: IndexPath) -> KeyboardAction {
        return actions[indexPath.item]
    }
    
    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath)
        cell.subviews.forEach { $0.removeFromSuperview() }
        let action = self.action(at: indexPath)
        let button = buttonCreator(action)
        cell.addSubview(button, fill: true)
        return cell
    }
}
