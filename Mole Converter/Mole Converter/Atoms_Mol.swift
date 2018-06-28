//
//  Atoms_Mol.swift
//  Mole Converter
//
//  Created by Model School B on 2016-11-21.
//  Copyright © 2016 Joseph Elias. All rights reserved.
//

import UIKit

class Atoms_Mol: UIViewController, UITextFieldDelegate {
    
    let v = ViewController();
    
    // Avogadros constant
    let avogadro = "6.0224e+23"
    
    // Purpose: Menubutton for navigation
    // Input: None
    // Output: None
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    // Purpose: Atoms text field that get input
    // Input: None
    // Output: None
    @IBOutlet weak var atoms: UITextField!
    
    // Purpose: Moles label
    // Input: none
    // Output: none
    @IBOutlet weak var moles: UILabel!
    
    // Purpose: Calculate moles # when button clicked
    // Input: Button clicked
    // Output: none
    @IBAction func calculate(_ sender: UIButton) {
        if atoms.hasText {   // catch null input error
            // entered number of atoms
            let a = atoms.text!
            if (Double(myFormat: a) != nil) {  // if entered element is valid
                // number of atoms converted to a double from scientific notation
                let f = Double(atoms.text!)
                // format string
                let x = NSString(format: "%.3f", v.atomsToMol(atoms: f!))
                // send out formatted values
                self.moles.text = "\(x) mol(s)"
            }  // end of inappropriate input
            else {
                // First error message
                self.moles.text = "Enter appropriate input"
            }  // end else
        }  // end if text is not empty
        else {
            // Second error message
            self.moles.text = "Enter values first"
        } // end else
    } // end method
    
    // Purpose: Set desired characteristics for menubutton
    // Input: None
    // Output: None
    override func viewDidLoad() {
        super.viewDidLoad()
        self.atoms.delegate = self
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        } // end if
    } // end method
    
    // Purpose: Set return key to remove keyboard
    // Input: textfield value
    // Output: succesful boolean
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        atoms.resignFirstResponder()
        return true
    } // end method

    
} // end class
