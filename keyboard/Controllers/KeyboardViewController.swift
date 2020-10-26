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

class KeyboardViewController: UIInputViewController {
    
    var keyboardView: UIView!
    var proxy: UITextDocumentProxy!
    
    @IBOutlet weak var previewLabel: UILabel!
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
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
            print("Downloaded model successfully")
            
        }
        
        translator.translate("how are you?") { translatedText, error in
            guard error == nil, let translatedText = translatedText else { return }
            
            print(translatedText)
        }
    }
    @IBAction func hideKeyboard(){
        dismissKeyboard()
        
    }
    @IBAction func deleteText(){
        proxy.deleteBackward()
        
        if let newText = proxy.documentContextBeforeInput {
            previewLabel.text! = newText
            translateText(text: newText)
        } else {
            previewLabel.text = ""
            translateText(text: "")
        }
        
    }
    
    @IBAction func spacePress() {
        proxy.insertText(" ")
        guard let newText = proxy.documentContextBeforeInput else { return }
        previewLabel.text! = newText
        translateText(text: newText)
    }
    
    @IBAction func keyPress(sender: UIButton!) {
        guard let typedCharacter = sender.titleLabel?.text else { return }
        proxy.insertText(typedCharacter)
        guard let newText = proxy.documentContextBeforeInput else { return }
        previewLabel.text! = newText
        translateText(text: newText)
    }
    
    @IBAction func returnPressed(sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("\n")
    }
    
    func loadKeyboard() {
        
        let keyboardNib = UINib(nibName: "View", bundle: nil)
        keyboardView = keyboardNib.instantiate(withOwner: self,options: nil)[0] as? UIView
        view.backgroundColor = keyboardView.backgroundColor
        view.addSubview(keyboardView)
        
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
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
            self.previewLabel.text = translatedText
        }
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        
    }
    
}

