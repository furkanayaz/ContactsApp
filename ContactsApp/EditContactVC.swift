//
//  EditContactVC.swift
//  ContactsApp
//
//  Created by FURKAN AYAZ on 31.01.2024.
//

import UIKit

class EditContactVC: UIViewController {
    @IBOutlet weak var tfFullName: UITextField!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    
    var chosenContact: Contact? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfFullName.text = chosenContact?.fullname
        tfPhoneNumber.text = chosenContact?.phonenumber
    }
    
    @IBAction func saveContact() {
        chosenContact?.fullname = tfFullName.text
        chosenContact?.phonenumber = tfPhoneNumber.text
        
        appDeleage.saveContext()
        
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "contact"), object: nil)

        self.navigationController?.popViewController(animated: true)
    }

}
