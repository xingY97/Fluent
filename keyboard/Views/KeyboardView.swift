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
    
    //MARK: kayboard layout Views
    @IBOutlet var contentView: UIInputView!
    //row1
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
    //row2
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
    //row3
    @IBOutlet weak var row3_a: UIButton!
    @IBOutlet weak var row3_s: UIButton!
    @IBOutlet weak var row3_d: UIButton!
    @IBOutlet weak var row3_f: UIButton!
    @IBOutlet weak var row3_g: UIButton!
    @IBOutlet weak var row3_h: UIButton!
    @IBOutlet weak var row3_j: UIButton!
    @IBOutlet weak var row3_k: UIButton!
    @IBOutlet weak var row3_l: UIButton!
    //row4
    @IBOutlet weak var row4_shift: UIButton!
    @IBOutlet weak var row4_z: UIButton!
    @IBOutlet weak var row4_x: UIButton!
    @IBOutlet weak var row4_c: UIButton!
    @IBOutlet weak var row4_v: UIButton!
    @IBOutlet weak var row4_b: UIButton!
    @IBOutlet weak var row4_n: UIButton!
    @IBOutlet weak var row4_m: UIButton!
    @IBOutlet weak var row4_delete: UIButton!
    //row5
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
    

    @IBAction func symbols(_ sender: AnyObject) {
        delegate.symples(sender: sender)
    }
    
    
    func updateKeyboardState(with state: KeyboardState) {
        keyBoardState = state
        switch state {
        case .regular:
            //print("Make keyboard regular")
            row2_q.setTitle("q", for: .normal)
            row2_w.setTitle("w", for: .normal)
            row2_e.setTitle("e", for: .normal)
            row2_r.setTitle("r", for: .normal)
            row2_t.setTitle("t", for: .normal)
            row2_y.setTitle("y", for: .normal)
            row2_u.setTitle("u", for: .normal)
            row2_i.setTitle("i", for: .normal)
            row2_o.setTitle("o", for: .normal)
            row2_p.setTitle("p", for: .normal)
            
            row3_a.setTitle("a", for: .normal)
            row3_s.setTitle("s", for: .normal)
            row3_d.setTitle("d", for: .normal)
            row3_f.setTitle("f", for: .normal)
            row3_g.setTitle("g", for: .normal)
            row3_h.setTitle("h", for: .normal)
            row3_j.setTitle("j", for: .normal)
            row3_k.setTitle("k", for: .normal)
            row3_l.setTitle("l", for: .normal)
            
            row4_z.setTitle("z", for: .normal)
            row4_x.setTitle("x", for: .normal)
            row4_c.setTitle("c", for: .normal)
            row4_v.setTitle("v", for: .normal)
            row4_b.setTitle("b", for: .normal)
            row4_n.setTitle("n", for: .normal)
            row4_m.setTitle("m", for: .normal)
                        
        case .symples:
            print("keyboard symbols")
            row2_q.setTitle("[", for: .normal)
            row2_w.setTitle("]", for: .normal)
            row2_e.setTitle("{", for: .normal)
            row2_r.setTitle("}", for: .normal)
            row2_t.setTitle("#", for: .normal)
            row2_y.setTitle("%", for: .normal)
            row2_u.setTitle("^", for: .normal)
            row2_i.setTitle("*", for: .normal)
            row2_o.setTitle("+", for: .normal)
            row2_p.setTitle("=", for: .normal)

            row3_a.setTitle("_", for: .normal)
            row3_s.setTitle("/", for: .normal)
            row3_d.setTitle("|", for: .normal)
            row3_f.setTitle("~", for: .normal)
            row3_g.setTitle("(", for: .normal)
            row3_h.setTitle(")", for: .normal)
            row3_j.setTitle("&", for: .normal)
            row3_k.setTitle("@", for: .normal)
            row3_l.setTitle("•", for: .normal)

            row4_z.setTitle("<", for: .normal)
            row4_x.setTitle(">", for: .normal)
            row4_c.setTitle("?", for: .normal)
            row4_v.setTitle("!", for: .normal)
            row4_b.setTitle("'", for: .normal)
            row4_n.setTitle(",", for: .normal)
            row4_m.setTitle(".", for: .normal)
            
        case .caps:
            print("upper/lower switching")
            row2_q.setTitle("Q", for: .normal)
            row2_w.setTitle("W", for: .normal)
            row2_e.setTitle("E", for: .normal)
            row2_r.setTitle("R", for: .normal)
            row2_t.setTitle("T", for: .normal)
            row2_y.setTitle("Y", for: .normal)
            row2_u.setTitle("U", for: .normal)
            row2_i.setTitle("I", for: .normal)
            row2_o.setTitle("O", for: .normal)
            row2_p.setTitle("P", for: .normal)

            row3_a.setTitle("A", for: .normal)
            row3_s.setTitle("S", for: .normal)
            row3_d.setTitle("D", for: .normal)
            row3_f.setTitle("F", for: .normal)
            row3_g.setTitle("G", for: .normal)
            row3_h.setTitle("H", for: .normal)
            row3_j.setTitle("J", for: .normal)
            row3_k.setTitle("K", for: .normal)
            row3_l.setTitle("L", for: .normal)

            row4_z.setTitle("Z", for: .normal)
            row4_x.setTitle("X", for: .normal)
            row4_c.setTitle("C", for: .normal)
            row4_v.setTitle("V", for: .normal)
            row4_b.setTitle("B", for: .normal)
            row4_n.setTitle("N", for: .normal)
            row4_m.setTitle("M", for: .normal)
            
            
        }
        
    }

}
