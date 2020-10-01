//
//  ScrollableLabel.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-12-09.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This label is used by `AutocompleteToolbar` by default when
 no custom `buttonCreator` is provided. It mimics the native
 autocomplete label which scrolls if its content doesn't fit
 its frame.

 `TODO` - Implement horizontal blur.
 */
open class AutocompleteToolbarLabel: UIView {
    
    
    // MARK: - Initialization
    
    public convenience init(text: String, textDocumentProxy: UITextDocumentProxy) {
        self.init()
        self.text = text
        self.textDocumentProxy = textDocumentProxy
        setup()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        handleLayoutChange()
    }
    
    
    // MARK: - Properties
    
    public var text: String {
        get { centeredLabel.text ?? "" }
        set {
            accessibilityLabel = newValue
            centeredLabel.text = newValue
            scrollViewLabel.text = newValue
        }
    }
    
    public var textMargins: CGFloat = 8 {
        didSet {
            scrollView.contentInset.left = textMargins
            scrollView.contentInset.right = textMargins
        }
    }
    
    private var isScrollingEnabled: Bool {
        scrollContentWidth > (scrollFrameWidth - textMargins)
    }
    
    private var scrollContentWidth: CGFloat {
        scrollView.contentSize.width
    }
    
    private var scrollFrameWidth: CGFloat {
        scrollView.frame.size.width
    }
    
    private weak var textDocumentProxy: UITextDocumentProxy?
    
    
    private var hasPerformedScrollToEnd = false
    
    
    // MARK: - Views
    
    public lazy var centeredLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        return view
    }()
    
    public lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.addSubview(scrollViewLabel, fill: true)
        view.contentInset = .init(top: 0, left: textMargins, bottom: 0, right: textMargins)
        view.heightAnchor.constraint(equalTo: scrollViewLabel.heightAnchor, multiplier: 1).isActive = true
        return view
    }()
    
    public lazy var scrollViewLabel: UILabel = {
        UILabel()
    }()
    
    public lazy var separator: AutocompleteToolbarSeparator = {
        AutocompleteToolbarSeparator()
    }()
    
    
    // MARK: - Functions
    
    public func scrollToEndIfNeeded() {
        if hasPerformedScrollToEnd { return }
        hasPerformedScrollToEnd = true
        guard isScrollingEnabled else { return }
        let offset = scrollContentWidth - scrollFrameWidth + textMargins
        scrollView.contentOffset.x = offset
    }
    
    private func setupAlphaMask() {
        let gradient = CAGradientLayer()
        gradient.frame = scrollView.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.0, 0.1, 0.5, 0.9, 1.0]
        scrollView.layer.mask = gradient
    }
}


// MARK: - Setup

private extension AutocompleteToolbarLabel {
    
    func setup() {
        setupAccessibility()
        setupSubviews()
        setupTapAction()
    }
    
    func setupSubviews() {
        setupSubview(centeredLabel)
        setupSubview(scrollView)
        addTrailingSubview(separator, width: 0.5, height: 20.0)
    }
    
    func setupSubview(_ view: UIView) {
        view.isHidden = true
        addSubview(view, fill: true)
    }
    
    func setupTapAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)
    }
}


// MARK: - Private Functions

private extension AutocompleteToolbarLabel {
    
    func handleLayoutChange() {
        DispatchQueue.main.async {
            self.refreshViewVisibility()
            self.scrollToEndIfNeeded()
        }
    }
    
    func refreshViewVisibility() {
        centeredLabel.isHidden = isScrollingEnabled
        scrollView.isVisible = isScrollingEnabled
    }
    
    func setupAccessibility() {
        accessibilityTraits = .button
    }
}


// MARK: - Private Actions

@objc private extension AutocompleteToolbarLabel {
    
    func handleTap() {
        textDocumentProxy?.replaceCurrentWord(with: text + " ")
    }
}
