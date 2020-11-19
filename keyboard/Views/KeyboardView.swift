//
//  KeyboardView.swift
//  keyboard
//
//  Created by XIN on 11/19/20.
//  Copyright © 2020 XIN. All rights reserved.
//

import UIKit

class KeyboardView: UIView {
    
    private var keyBoardState: KeyboardState
    var delegate: KeyboardViewController!
    
    //MARK: Views
    @IBOutlet var contentView: UIInputView!
    
    @IBOutlet weak var row1_1: UIButton!
    @IBOutlet weak var row1_2: UIButton!
    @IBOutlet weak var row1_3: UIButton!
    @IBOutlet weak var row1_4: UIButton!
    @IBOutlet weak var row1_5: UIButton!
    @IBOutlet weak var row1_6: UIButton!
    @IBOutlet weak var row1_7: UIButton!
    @IBOutlet weak var row1_8: UIButton!
    @IBOutlet weak var row1_9: UIButton!
    @IBOutlet weak var row1_0: UIButton!
    @IBOutlet weak var row2_q: UIButton!
    @IBOutlet weak var row2_w: UIButton!
    @IBOutlet weak var row2_e: UIButton!
    @IBOutlet weak var row2_r: UIButton!
    @IBOutlet weak var row2_t: UIButton!
    @IBOutlet weak var row2_y: UIButton!
    @IBOutlet weak var row2_u: UIButton!
    @IBOutlet weak var row2_i: UIButton!
    @IBOutlet weak var row2_o: UIButton!
    @IBOutlet weak var row2_p: UIButton!
    @IBOutlet weak var row3_a: UIButton!
    @IBOutlet weak var row3_s: UIButton!
    @IBOutlet weak var row3_d: UIButton!
    @IBOutlet weak var row3_f: UIButton!
    
    @IBOutlet weak var row3_g: UIButton!
    @IBOutlet weak var row3_h: UIButton!
    @IBOutlet weak var row3_j: UIButton!
    @IBOutlet weak var row3_k: UIButton!
    @IBOutlet weak var row3_l: UIButton!
    
    @IBOutlet weak var row4_shift: UIButton!
    @IBOutlet weak var row4_z: UIButton!
    @IBOutlet weak var row4_x: UIButton!
    @IBOutlet weak var row4_c: UIButton!
    @IBOutlet weak var row4_v: UIButton!
    @IBOutlet weak var row4_b: UIButton!
    @IBOutlet weak var row4_n: UIButton!
    @IBOutlet weak var row4_m: UIButton!
    @IBOutlet weak var row4_delete: UIButton!
    
    
    @IBOutlet weak var row5_hide: UIButton!
    @IBOutlet weak var row5_space: UIButton!
    @IBOutlet weak var row5_enter: UIButton!
    
    @IBOutlet weak var previewLabel: UILabel!
    
    //MARK: Initializers
    required init(keyBoardState: KeyboardState = .regular, vc: KeyboardViewController) {
        self.keyBoardState = keyBoardState
        self.delegate = vc
        super.init(frame: .zero)
        commonInit()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed("KeyboardView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    fileprivate func setupViews() {
        
    }
    
    
    @IBAction func hideKeyboard(){
        delegate.dismissKeyboard()
    }
    @IBAction func deleteText(){
        delegate.deleteText()
    }
    
    @IBAction func spacePress() {
        delegate.spacePress()
    }
    
    @IBAction func keyPress(sender: UIButton!) {
        delegate.keyPress(sender: sender)
    }
    
    @IBAction func returnPressed(sender: AnyObject) {
        delegate.returnPressed(sender: sender)
    }
    
    @IBAction func shiftKey(sender: AnyObject) {
        delegate.shiftKey(sender: sender)
    }
    
    func updateKeyboardState(with state: KeyboardState) {
        keyBoardState = state
        switch state {
        case .regular:
            print("Make keyboard regular")
        case .shifted:
            print("Make keyboard shifted")
            row1_1.setTitle("EYO", for: .normal)
        }
    }
}
