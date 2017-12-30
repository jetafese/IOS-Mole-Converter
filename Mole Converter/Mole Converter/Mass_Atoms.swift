//
//  Mass_Atoms.swift
//  Mole Converter
//
//  Created by Model School B on 2016-11-30.
//  Copyright © 2016 Joseph Elias. All rights reserved.
//

import UIKit

class Mass_Atoms: UIViewController, UITextFieldDelegate {
    
    let v = ViewController()     // object with the dictionary
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var massA: UITextField!
    
    @IBOutlet weak var elementA: UITextField!
    
    @IBOutlet weak var atomsA: UILabel!
    
    
    @IBAction func calculateA(_ sender: UIButton) {
        
        // catch null input error
        if elementA.hasText && massA.hasText {
            
            let element = elementA.text!    // entered element
            let mass = massA.text!          // entered mass
            
            var moles : Double              // moles to be put out
            
            if (Double(myFormat: mass) != nil) {  // if entered element is valid
                
                let m = Double(mass)!       // local variable for entered mass
                
                moles = v.massToMole(element, ma: m, label: atomsA)    // calculate moles
                let f = v.molToAtoms(mol: moles)   // calculate moles
                // use extension to write result in scientific notation
                self.atomsA.text = "\(f.scientificStyle) particles"
                
            }  // end of inappropriate input
                
            else {
                
                self.atomsA.text = "Enter appropriate input"   // First error message
                
            }  // end else
        }  // end if text is not empty
            
        else {
            
            self.atomsA.text = "Enter values first"
            
        } // end else
    } // end method
    
    // Purpose: Set desired characteristics for menubutton
    // Input: None
    // Output: None
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.elementA.delegate = self
        self.massA.delegate = self
        
        // creates menu button call when swiped right
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        } // end if
    } // end method
    
    // Purpose: Set return key to remove keyboard
    // Input: textfield value
    // Output: succesful boolean
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        elementA.resignFirstResponder()
        massA.resignFirstResponder()
        return true
        
    }// end method
} // end class

