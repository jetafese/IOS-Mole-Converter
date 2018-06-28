//
//  ViewController.swift
//  Mole Converter
//
//  Created by Model School B on 2016-08-16.
//  Copyright © 2016 Joseph Elias. All rights reserved.
//

import UIKit

// Purpose: Stack implementation
// Input: None
// Output: None
struct Stack<Element> {
    var items = [Element]()
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    var count: Int {
        return items.count
    }
} // end struct

// Purpose: String extension
// Input: None
// Output: None
extension String {
    
    var length: Int {
        return self.characters.count
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        let it = start..<end
        
        return self.substring(with: it)
//        return self[Range(start ..< end)]
    }
    
    subscript (i: Int) -> String {
        return self[Range(i ..< i + 1)]
    }
    
    func substring(from: Int) -> String {
        return self[Range(min(from, length) ..< length)]
    }
    
    func substring(to: Int) -> String {
        return self[Range(0 ..< max(0, to))]
    }
} // end extension

/************************** Start Class ********************************/

class ViewController: UIViewController {

    // avogadros constant
    let avogadro = "6.0224e+23"
    
    var stack = Stack<Double>();    // internal stack
    
    
    // Purpose: Start the app
    // Input: None
    // Output: None
    override func viewDidLoad() {
        super.viewDidLoad()
    } // end method

    // Purpose: No idea what this does
    // Input: None
    // Output: None
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Purpose: Dictionatry of elements for the project
    // Input: Letter representation of element
    // Output: Molecular weight
    func dict(_ s: String ) -> Double {
        
        var dictionary: [String:Double] = [
            // Family 1
            "H": 1.0079,"Li": 6.941, "Na": 22.9898,"K": 39.0983, "Rb": 85.4678, "Cs": 132.9055,
            // Family 2
            "Be": 9.0122, "Mg": 24.3050, "Ca": 40.078,"Sr": 87.62, "Ba": 137.327,
            // Family 3
            "Sc": 44.9559 , "Y": 88.9059, "Lu": 174.967,
            // Family 4
            "Ti": 47.867 , "Zr": 91.224, "Hf": 178.49,
            // Family 5
            "V": 50.9415 , "Nb": 92.9064, "Ta": 180.9479,
            // Family 6
            "Cr": 51.9961 , "Mo": 95.94, "W": 183.84,
            // Family 6
            "Mn": 54.9380 , "Tc": 97.9072, "Re": 186.207,
            // Family 7
            "Fe": 55.845, "Ru": 101.07, "Os": 190.23,
            // Family 8
            "Co": 58.9332,"Rh": 102.9055, "Ir": 192.217,
            // Family 8
            "Ni": 58.6934,"Pd": 106.42, "Pt": 195.078,
            // Family 9
            "Cu": 63.546, "Ag": 107.8682,"Au": 196.9666,
            // Family 10
            "Zn": 65.39,"Cd": 112.411, "Hg": 200.59,
            // Family 11
            "B": 10.811,"Al": 26.9815,"Ga": 69.723,"In": 114.818, "Tl": 204.3833,
            // Family 12
            "C": 12.0107,"Si": 28.0855,"Ge": 72.64,"Sn": 118.710,"Pb": 207.2,
            // Family 13
            "N": 14.0067,"P": 30.9738,"As": 74.9216,"Sb": 121.760, "Bi": 208.9804,
            // Family 14
            "O": 15.9994,"S": 32.065,"Se": 78.96,"Te": 127.60, "Po": 208.98,
            // Family 15
            "F": 18.9984,"Cl": 35.453,"Br": 79.904,"I": 126.9045, "At": 209.99,
            // Family 16
            "He": 4.0026,"Ne": 20.1797,"Ar": 39.948,"Kr": 83.798,"Xe": 131.293, "Rn": 222.02
        ]
        
        return dictionary[s]!   // return molecular weight
    } // end method
    
    // Purpose: Check for element availability
    // Input: Symbol
    // Output: True(0) or false(1)
    func confirmElement(_ e : String) -> Bool {
        var x : Bool // Control variable
        let elements = [ "H","Li","Na","K","Rb","Cs","Be","Mg","Ca","Sr","Ba","Sc","Y","Lu","Ti","Zr","Hf","V","Nb","Ta","Cr","Mo","W","Mn","Tc","Re","Fe","Ru","Os","Co","Rh","Ir","Ni","Pd","Pt","Cu","Ag","Au","Zn","Hg","Cd","B","Al","Ga","In","Tl","C","Si","Ge","Sn","Pb",
                         "N","P","As","Sb","Bi","O","S","Se","Te","Po","F","Cl","Br","I","At","He","Ne","Ar","Kr","Xe","Rn"]
        if elements.contains(e) {
            x = true   // true
        } // end if
        else {
            x = false    // false
        } // end else
        return x
    } // end method
    
    // Purpose: Convert mass to moles
    // Input: mass
    // Output: Number of moles
    func massToMole (_ e : String, ma : Double, label: UILabel) -> Double {
        
        var moles : Double
        var molarMass : Double
        
        
        molarMass = getMolarMass(e: e, label: label)
        
        moles = ma / molarMass
        
        return moles
        
    }// end method
    
    // Purpose: Convert moles to mass
    // Input: moles
    // Output: Mass
    func moleToMass(_ e : String, mo : Double, label: UILabel) -> Double {
        
        var mass : Double
        var molarMass : Double
        
        
        molarMass = getMolarMass(e: e, label: label)
        
        mass = mo * molarMass
        
        return mass
        
    }// end method
    
    // Purpose: Convert mols to atoms
    // Input: Molar value
    // Output: Number of atoms per mol
    func molToAtoms(mol:Double) -> Double {
        
        let atom = mol * Double(avogadro)!;
        
        return atom;
    } // end method

    // Purpose: Convert atoms to moles
    // Input: # of atoms
    // Output: Number of moles
    func atomsToMol(atoms:Double) -> Double {
        
        let mol = atoms / Double(avogadro)!;
        
        return mol;
    } // end method

    
    // Purpose: Calculate molar mass using stack method
    // Input: String
    // Output: molar mass
    
    func getMolarMass(e : String, label: UILabel) -> Double{
        
        var mass = 0.0;                 // molar mass
        
        
        for x in 0..<e.characters.count{
            
            if(e.isEmpty == false){
                
           
            // upper character
            if(confirmElement(e[x])){
                
                stack.push(dict(e[x]));    // get valid mass and add to stack
            }
                
            if(confirmElement(e[x] + e[x+1])){
                if(stack.count == 0){
                     stack.push(dict(e[x] + e[x+1]));
                }
                else{
                     var _ = stack.pop()
                     stack.push(dict(e[x] + e[x+1]));
                }
                
            }
            
                if Int(e[x]) != nil {
            
                let s = stack.pop()
                let m = Double(e[x])!
                stack.push(s * m)
            }
                
            } else{
                label.text = "Enter Correct Formula"
            } // end else

                            
        }// end for loop
         
    // calculate total molar mass

        for _ in 0..<stack.count {
            
            mass += stack.pop()
        
        } // end for
        
        return mass
        
    } // end method

    
} // end class

