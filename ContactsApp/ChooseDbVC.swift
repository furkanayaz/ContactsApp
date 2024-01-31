//
//  ViewController.swift
//  ContactsApp
//
//  Created by FURKAN AYAZ on 31.01.2024.
//

import UIKit

class ChooseDbVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func chooseSqlite() {
        self.performSegue(withIdentifier: "chooseDbToContacts", sender: false)
    }
    
    @IBAction func chooseCoreData() {
        self.performSegue(withIdentifier: "chooseDbToContacts", sender: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "chooseDbToContacts" {
            (segue.destination as! ContactsVC).whichDb = sender as? Bool
        }
        
    }
}

