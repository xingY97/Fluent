//
//  englishKeyboard.swift
//  keyboard
//
//  Created by XIN on 9/29/20.
//  Copyright © 2020 XIN. All rights reserved.
//

import KeyboardKit

/**
 This demo keyboard mimicks an English alphabetic keyboard.
 */
struct AlphabeticKeyboard: DemoKeyboard {
    
    init(uppercased: Bool, in viewController: KeyboardViewController) {
        actions = AlphabeticKeyboard.actions(
            uppercased: uppercased,
            in: viewController)
    }

    let actions: KeyboardActionRows
}

private extension AlphabeticKeyboard {
    
    static func actions(
        uppercased: Bool,
        in viewController: KeyboardViewController) -> KeyboardActionRows {
        KeyboardActionRows(characters: characters(uppercased: uppercased))
            .addingSideActions(uppercased: uppercased)
            .appending(bottomActions(leftmost: switchAction, for: viewController))
    }
    
    static let characters: [[String]] = [
        ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
        ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
        ["z", "x", "c", "v", "b", "n", "m"]
    ]
    
    static func characters(uppercased: Bool) -> [[String]] {
        uppercased ? characters.uppercased() : characters
    }
    
    static var switchAction: KeyboardAction {
        .keyboardType(.numeric)
    }
}

private extension Sequence where Iterator.Element == KeyboardActionRow {
    
    func addingSideActions(uppercased: Bool) -> [Iterator.Element] {
        var result = map { $0 }
        result[2].insert(uppercased ? .shift(currentState: .uppercased) : .shift(currentState: .lowercased), at: 0)
        result[2].insert(.none, at: 1)
        result[2].append(.none)
        result[2].append(.backspace)
        return result
    }
}

