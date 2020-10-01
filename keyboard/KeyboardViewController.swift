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
    var proxy: UITextDocumentProxy!
    
    @IBOutlet weak var previewLabel: UILabel!

    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        proxy = textDocumentProxy
        loadKeyboard()
    }
    @IBAction func hideKeyboard(){
        dismissKeyboard()
        
    }
    @IBAction func deleteText(){
        proxy.deleteBackward()
        
        if let newText = proxy.documentContextBeforeInput {
            previewLabel.text! = newText
        } else {
            previewLabel.text = ""
        }

    }
    
    @IBAction func spacePress() {
        proxy.insertText(" ")
        guard let newText = proxy.documentContextBeforeInput else { return }
        previewLabel.text! = newText
    }
    
    @IBAction func keyPress(sender: UIButton!) {
        guard let typedCharacter = sender.titleLabel?.text else { return }
        proxy.insertText(typedCharacter)
        guard let newText = proxy.documentContextBeforeInput else { return }
        previewLabel.text! = newText
        
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

    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        

    }

}

