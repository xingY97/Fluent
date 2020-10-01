//
//  KeyboardCollectionView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-23.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This class can be used as a base class for collection views
 that present keyboard button cells for a set of actions.
 
 This class must be subclassed, since it returns empty cells
 for each action. `KeyboardKit` has two built-in subclasses:
 
 * `KeyboardButtonCollectionView` displays single buttons
 * `KeyboardButtonRowCollectionView` displays button rows
 */
open class KeyboardCollectionView: UICollectionView, KeyboardStackViewComponent, UICollectionViewDataSource {
    
    
    // MARK: - Initialization
    
    public init(actions: [KeyboardAction]) {
        self.actions = actions
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        dataSource = self
        backgroundColor = .clear
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.actions = []
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Properties
    
    public var actions: [KeyboardAction] {
        didSet { refresh() }
    }
    
    public let cellIdentifier = "Cell"
    
    public var heightConstraint: NSLayoutConstraint?
    
    
    // MARK: - Public Functions
    
    open func refresh() {
        collectionViewLayout.invalidateLayout()
        reloadData()
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        actions.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
    }
}
