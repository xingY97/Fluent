//
//  KeyboardViewController.swift
//  keyboard
//
//  Created by XIN on 9/15/20.
//  Copyright © 2020 XIN. All rights reserved.
//

import UIKit
import MLKit
import Firebase



enum KeyboardState {
    case regular, symples, caps
}

class KeyboardViewController: UIInputViewController {
    
    
    var proxy: UITextDocumentProxy!
    var keyboardState: KeyboardState = .regular {
        didSet { keyboardView.updateKeyboardState(with: keyboardState) }
    }
    
    lazy var keyboardView: KeyboardView = {
        let view = KeyboardView(vc: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
    }
    
    let conditions = ModelDownloadConditions(
        allowsCellularAccess: false,
        allowsBackgroundDownloading: false
    )
    
    var options: TranslatorOptions = {
        let options = TranslatorOptions(sourceLanguage: .english, targetLanguage: .spanish)
        return options
    }()
    
    var translator: Translator = {
        let translator = Translator.translator(options:  TranslatorOptions(sourceLanguage: .english, targetLanguage: .spanish))
        
        return translator
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        proxy = textDocumentProxy
        loadKeyboard()
        
        translator.downloadModelIfNeeded(with: conditions) { [weak self] error in
            guard error == nil, let self = self else {
                print(error ?? "Error downloading!")
                return
            }
            //print("Downloaded model successfully")
            
        }
        translator.translate("how are you?") { translatedText, error in
            guard error == nil, let translatedText = translatedText else { return }
        }
    }
    @IBAction func hideKeyboard(){
        dismissKeyboard()

    }
    
    @IBAction func deleteText(){
        proxy.deleteBackward()
        
        if let newText = proxy.documentContextBeforeInput {
            keyboardView.previewLabel.text! = newText
            translateText(text: newText)
        } else {
            keyboardView.previewLabel.text = ""
            translateText(text: "")
        }
        
    }
    
    func spacePress() {
        proxy.insertText(" ")
        guard let newText = proxy.documentContextBeforeInput else { return }
        keyboardView.previewLabel.text! = newText
        translateText(text: newText)

    }
    
    func keyPress(sender: UIButton!) {
        guard let typedCharacter = sender.titleLabel?.text else { return }
        proxy.insertText(typedCharacter)
        guard let newText = proxy.documentContextBeforeInput else { return }
        keyboardView.previewLabel.text! = newText
        translateText(text: newText)
        spellCheck(text: newText)
    }
    
    func returnPressed(sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("\n")
    }
    
    func shiftKey(sender: AnyObject) {

        if keyboardState == .regular {
          keyboardState = .caps
        } else {
          keyboardState = .regular
        }
    }
    
    func symples(sender: AnyObject) {
        if keyboardState == .regular{
            keyboardState = .symples
        } else if keyboardState == .caps {
            keyboardState = .symples
        } else {
            keyboardState = .regular
        }
    }
    
    func loadKeyboard() {
        
        view.backgroundColor = keyboardView.backgroundColor
        view.addSubview(keyboardView)
        NSLayoutConstraint.activate([
            keyboardView.leftAnchor.constraint(equalTo: inputView!.leftAnchor),
            keyboardView.topAnchor.constraint(equalTo: inputView!.topAnchor),
            keyboardView.rightAnchor.constraint(equalTo: inputView!.rightAnchor),
            keyboardView.bottomAnchor.constraint(equalTo: inputView!.bottomAnchor)
        ])
    }
    
    func translateText(text: String) {
        translator.translate(text) { translatedText, error in
            guard error == nil, let translatedText = translatedText else { return }
            print(translatedText)
            self.keyboardView.previewLabel.text = translatedText
        }
    }
    
    func spellCheck(text: String){
        let textChecker = UITextChecker()
        let misspelledRange =
        textChecker.rangeOfMisspelledWord(in: text,
                                          range: NSRange(0..<text.utf16.count),
                                          startingAt: 0,
                                          wrap: false,
                                          language: "en_US")
        let fixedwords = textChecker.guesses(forWordRange: misspelledRange, in: text, language: "en_US")//?.first //gets the first word only
        print(fixedwords)
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    }
    
}
