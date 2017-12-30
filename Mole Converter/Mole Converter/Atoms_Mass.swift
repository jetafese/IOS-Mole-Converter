//
//  cMass_Mole.swift
//  Mole Converter
//
//  Created by Model School B on 2016-11-26.
//  Copyright © 2016 Joseph Elias. All rights reserved.
//

import UIKit

class Atoms_Mass: UIViewController, UITextFieldDelegate {
    
    let v = ViewController();
    
    @IBOutlet weak var atoms: UITextField!
    
    @IBOutlet weak var element: UITextField!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var mass: UILabel!
    
    @IBAction func Convert(_ sender: AnyObject) {
        
        if atoms.hasText {   // catch null input error
            // entered number of atoms
            let a = atoms.text!
            if (Double(myFormat: a) != nil) {  // if entered element is valid
                // number of atoms converted to a double from scientific notation
                let f = Double(atoms.text!)
                let e = v.atomsToMol(atoms: f!)
                // format string
                let x = NSString(format: "%.3f", (e * v.getMolarMass(e: element.text!, label: mass)))
                // send out formatted values
                self.mass.text = "\(x) grams of \(element.text!)"
            }  // end of inappropriate input
            else {
                // First error message
                self.mass.text = "Enter appropriate input"
            }  // end else
        }  // end if text is not empty
        else {
            // Second error message
            self.mass.text = "Enter values first"
        } // end else

    }
    // Purpose: Set desired characteristics for menubutton
    // Input: None
    // Output: None
    override func viewDidLoad() {
        super.viewDidLoad()
        self.atoms.delegate = self
        self.element.delegate = self
        
        
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
        element.resignFirstResponder()
        return true
    } // end method
  } // end class
