import UIKit

class Mass_mole: UIViewController, UITextFieldDelegate {
    
    let v = ViewController()     // object with the dictionary
    
    // Purpose: Menubutton for navigation
    // Input: None
    // Output: None
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    // Purpose: Textfield for the mass
    // Input: None
    // Output: None
    @IBOutlet weak var massA: UITextField!

    // Purpose: Elements text field that get input
    // Input: None
    // Output: None
    @IBOutlet weak var elementA: UITextField!
    
    // Purpose: Moles label
    // Input: none
    // Output: none
    @IBOutlet weak var molesA: UILabel!
    
    // Purpose: Calculate moles # when button clicked
    // Input: Button clicked
    // Output: none
    @IBAction func calculateA(_ sender: UIButton) {
        
    if elementA.hasText && massA.hasText {   // catch null input error
           
            let element = elementA.text!    // entered element
            let mass = massA.text!          // entered mass
        
            var moles : Double              // moles to be put out
            
            if (Double(myFormat: mass) != nil) {  // if entered element is valid
            
                let m = Double(mass)!       // local variable for entered mass
                
                moles = v.massToMole(element, ma: m, label: molesA)    // calculate moles
                
                let x =  NSString(format: "%.3f",moles)
                
                self.molesA.text = "\(x) mol of \(element)"   // send out obtained values
                
            }  // end of inappropriate input
                
            else {
                
                self.molesA.text = "Enter appropriate input"   // First error message
                
            }  // end else
            }  // end if text is not empty
            
            else {
            
                self.molesA.text = "Enter values first"
            
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
        }
        
    }
    
    // Purpose: Set return key to remove keyboard
    // Input: textfield value
    // Output: succesful boolean
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        elementA.resignFirstResponder()
        massA.resignFirstResponder()
        return true

    } // end method
} // end class
