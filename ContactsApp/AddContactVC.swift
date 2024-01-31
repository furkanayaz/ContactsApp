//
//  AddContactVC.swift
//  ContactsApp
//
//  Created by FURKAN AYAZ on 31.01.2024.
//

import UIKit

class AddContactVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func addContact() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
