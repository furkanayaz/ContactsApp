//
//  ContactsVC.swift
//  ContactsApp
//
//  Created by FURKAN AYAZ on 31.01.2024.
//

import UIKit
import CoreData

class ContactsVC: UIViewController {
    @IBOutlet weak var contactsView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var whichDb: Bool? = nil
    
    var isSearch: Bool = false
    
    var contacts: [Contact] = [
        Contact(fullName: "Furkan Ayaz", phoneNumber: "+90 553 975 99 57"),
        Contact(fullName: "Emre Altunbilek", phoneNumber: "+90 549 827 65 13"),
        Contact(fullName: "Kasım Adalan", phoneNumber: "+90 546 785 14 53"),
        Contact(fullName: "Atıl Samancıoğlu", phoneNumber: "+90 536 425 88 45")
    ]
    
    var filteredContacts: [Contact] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactsView.delegate = self
        contactsView.dataSource = self
        searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "contactsToEditContact" {
            (segue.destination as? EditContactVC)?.chosenContact = sender as? Contact
        }
    }
    
    @IBAction func addContact(_ sender: Any) {
        self.performSegue(withIdentifier: "contactsToAddContact", sender: nil)
    }
    

}

extension ContactsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell
        
        let contactAtPosition: Contact = if self.isSearch { self.filteredContacts[indexPath.row] } else { self.contacts[indexPath.row] }
        
        cell.fullName.text = contactAtPosition.fullName
        cell.phoneNumber.text = contactAtPosition.phoneNumber
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return if self.isSearch {
            self.filteredContacts.count
        } else {
            self.contacts.count
        }
    }
    /*func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
    }*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chosenContact: Contact = contacts[indexPath.row]
        self.performSegue(withIdentifier: "contactsToEditContact", sender: chosenContact)
    }
}

extension ContactsVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.isSearch = !searchText.isEmpty
        
        if self.isSearch {
            filteredContacts = contacts.filter({
                $0.fullName.lowercased().contains(searchText.lowercased()) || $0.phoneNumber.contains(searchText)
            })
        }
        
        self.contactsView.reloadData()
    }
}
