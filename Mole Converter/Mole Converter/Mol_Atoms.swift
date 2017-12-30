//
//  Mol_Atoms.swift
//  Mole Converter
//
//  Created by Model School B on 2016-11-20.
//  Copyright © 2016 Joseph Elias. All rights reserved.
//

import UIKit

// Extension that handles scientific notaion output
extension Double {
    struct Number {
        static var formatter = NumberFormatter()
    } // end structure declaration
    var scientificStyle: String {
        Number.formatter.numberStyle = .scientific
        Number.formatter.positiveFormat = "0.###E+0"
        Number.formatter.exponentSymbol = "e"
        return Number.formatter.string(from: NSNumber(value: self)) ?? description
    } // end variable declaration
} // end extension

class Mol_Atoms: UIViewController, UITextFieldDelegate {
    
    let v = ViewController()
    
    // Purpose: Menubutton for navigation
    // Input: None
    // Output: None
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    // Purpose: Moles text field that get input
    // Input: None
    // Output: None
    @IBOutlet weak var moles: UITextField!
    
    // Purpose: Atoms label
    // Input: none
    // Output: none
    @IBOutlet weak var atoms: UILabel!
    
    // Purpose: Calculate atoms # when button clicked
    // Input: Button clicked
    // Output: none
    @IBAction func calculate(_ sender: UIButton) {
        if (moles.hasText) {   // catch null input error
            let m = moles.text!      // entered moles
            // if entered element is valid
            if (Double(myFormat: m) != nil) {
                // local variable for entered mass
                let mole = Double(m)!
                let f = v.molToAtoms(mol: mole)   // calculate moles
                // use extension to write result in scientific notation
                    self.atoms.text = "\(f.scientificStyle) particles"
            }  // end of inappropriate input
            else {
                // First error message
                self.atoms.text = "Enter appropriate input"
            }  // end else
        }  // end if text is not empty
        else {
            // Second error message
            self.atoms.text = "Enter values first"
        } // end else
    } // end method

    // Purpose: Set desired characteristics for menubutton
    // Input: None
    // Output: None
    override func viewDidLoad() {
        super.viewDidLoad() // get superclass characteristics
        self.moles.delegate = self
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        } // end if
    } // end method
    
    // Purpose: Set return key to remove keyboard
    // Input: textfield value
    // Output: succesful boolean
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool {
        moles.resignFirstResponder()
        return true
    }// end method
} // end class
