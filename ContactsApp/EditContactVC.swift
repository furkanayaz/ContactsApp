//
//  EditContactVC.swift
//  ContactsApp
//
//  Created by FURKAN AYAZ on 31.01.2024.
//

import UIKit

class EditContactVC: UIViewController {
    var chosenContact: ContactModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveContact() {
        self.navigationController?.popViewController(animated: true)
    }

}
