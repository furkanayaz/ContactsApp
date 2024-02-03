//
//  AddContactVC.swift
//  ContactsApp
//
//  Created by FURKAN AYAZ on 31.01.2024.
//

import UIKit

class AddContactVC: UIViewController {
    @IBOutlet weak var tfFullName: UITextField!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func add() {
        let fullName: String? = tfFullName.text
        let phoneNumber: String? = tfPhoneNumber.text
        
        guard let fullName else {
            return
        }
        
        guard let phoneNumber else {
            return
        }
        
        let contact = Contact(context: context)
        contact.fullname = fullName
        contact.phonenumber = phoneNumber
        
        appDeleage.saveContext()
        NotificationCenter.default.post(name: NSNotification.Name.init("newContact"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func addContact() {
        add()
    }
    
}
