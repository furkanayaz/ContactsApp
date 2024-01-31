//
//  ContactsVC.swift
//  ContactsApp
//
//  Created by FURKAN AYAZ on 31.01.2024.
//

import UIKit

class ContactsVC: UIViewController {
    var whichDb: Bool? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("WhichDB: \(String(describing: whichDb))")
        
    }
    
    @IBAction func addContact(_ sender: Any) {
        self.performSegue(withIdentifier: "contactsToAddContact", sender: nil)
    }
    

}
