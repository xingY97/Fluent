//
//  KeyboardViewController.swift
//  keyboard
//
//  Created by XIN on 9/15/20.
//  Copyright © 2020 XIN. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    var keyboardView: UIView!
    
    @IBOutlet var nextKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
        //ios autocorrection
    var userLexicon: UILexicon?
    
    var currentWord: String? {
      var lastWord: String?
      // 1 use documentContextBeforeInput to get the text before the cursor
      if let stringBeforeCursor = textDocumentProxy.documentContextBeforeInput {
        
        // 2 enumerate each word of the string by using enumerateSubstrings
        stringBeforeCursor.enumerateSubstrings(in: stringBeforeCursor.startIndex...,
                                               options: .byWords)
        { word, _, _, _ in
          // 3when enumeration ends, whatever lastword contains will be the last word before the cursor
          if let word = word {
            lastWord = word
          }
        }
      }
      return lastWord
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadKeyboard()
        
    }
    @IBAction func hideKeyboard(){
        dismissKeyboard()
        
    }
    @IBAction func deleteText(){
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.deleteBackward()
    }
    @IBAction func nextKeyboard() {
        advanceToNextInputMode()
    }
    @IBAction func spacePress() {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText(" ")
        
    }
    
    @IBAction func keyPress(sender: UIButton!) {
        
        let typedCharacter = sender.titleLabel?.text
        
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText(typedCharacter!)
        
    }
    
    func loadKeyboard() {
        
        let keyboardNib = UINib(nibName: "View", bundle: nil)
        keyboardView = keyboardNib.instantiate(withOwner: self,options: nil)[0] as? UIView
        view.backgroundColor = keyboardView.backgroundColor
        view.addSubview(keyboardView)
        
    }

    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.

    }

}
// MARK: - Private methods
private extension KeyboardViewController {
  func attemptToReplaceCurrentWord() {
    // 1 ensure that user lexicon and current word exist before continuing
    guard let entries = userLexicon?.entries,
      let currentWord = currentWord?.lowercased() else {
        return
    }

    // 2 Filter the lexicon data by comparing userInput to the current word. omw=on my way
    let replacementEntries = entries.filter {
      $0.userInput.lowercased() == currentWord
    }

    if let replacement = replacementEntries.first {
      // 3 if find match, delete th ecurrent word from the text input view
      for _ in 0..<currentWord.count {
        textDocumentProxy.deleteBackward()
      }

      // 4 insert the replacementtext definded using the lexicon property documenttext
        
      textDocumentProxy.insertText(replacement.documentText)
    }
  }
}
