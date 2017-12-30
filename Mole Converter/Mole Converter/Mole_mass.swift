
import UIKit

// Purpose: Double extension
// Input: None
// Output: None
extension Double {
    init?(myFormat:String) {
        guard let
            standardDouble = Double(myFormat),
            let firstChar: Character? = myFormat.characters.first,
            let lastChar: Character? = myFormat.characters.last
            , firstChar != "." && lastChar != "."
            else { return nil }
        self = standardDouble
    }
} // end extension

/************************** Start Class ********************************/

class Mole_mass: UIViewController, UITextFieldDelegate {
    
    let v = ViewController()   // pointer to super class

    // Purpose: Menubutton for navigation
    // Input: None
    // Output: None
    @IBOutlet weak var menuButton: UIBarButtonItem!
   
    // Purpose: Textfield for the number of moles
    // Input: None
    // Output: None
    @IBOutlet weak var molesB: UITextField!
    
    // Purpose: Textfield for the element
    // Input: None
    // Output: None
    @IBOutlet weak var elementB: UITextField!
    
    // Purpose: Label for resultant mass
    // Input: None
    // Output: None
    @IBOutlet weak var massB: UILabel!
    
    // Purpose: Calculate mass
    // Input: Action performed
    // Output: None
    @IBAction func calculateB(_ sender: UIButton) {
        
     if elementB.hasText && molesB.hasText { // if text is not empty
        
        let element = elementB.text!
        let moles = molesB.text!
        
        var mass : Double
        
        if (Double(myFormat: moles) != nil){
            
            let mol = Double(moles)!
            mass = v.moleToMass(element, mo: mol, label: massB)
            let x = NSString(format: "%.3f",mass)
            self.massB.text = "\(x) grams of \(element)"
            
        } // end if
        else {
            
            self.massB.text = "Enter appropriate input"
        
        } // end else
        } // end if
        else {
        
            self.massB.text = "Enter values first"
        
        } // end else
    } // end calculateB
   
    // Purpose: Start the app
    // Input: None
    // Output: None
    override func viewDidLoad() {
        super.viewDidLoad()
        self.elementB.delegate = self
        self.molesB.delegate = self
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        } // end if
    } // end method
    
    // Purpose: Textfield behaviour
    // Input: None
    // Output: None
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool {
        elementB.resignFirstResponder()
        molesB.resignFirstResponder()

        return true
    }
   
    } // end class
