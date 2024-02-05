//
//  ContactsVC.swift
//  ContactsApp
//
//  Created by FURKAN AYAZ on 31.01.2024.
//

import UIKit
import CoreData

let appDeleage = UIApplication.shared.delegate as! AppDelegate
let context = appDeleage.persistentContainer.viewContext

class ContactsVC: UIViewController {
    @IBOutlet weak var contactsView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
        
    var isSearch: Bool = false
    
    var contacts: [Contact] = []
    
    var filteredContacts: [Contact] = []
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(fetchContacts), name: NSNotification.Name(rawValue: "contact"), object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactsView.delegate = self
        contactsView.dataSource = self
        searchBar.delegate = self
        
        fetchContacts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "contactsToEditContact" {
            (segue.destination as? EditContactVC)?.chosenContact = sender as? Contact
        }
    }
    
    @objc func fetchContacts() {
        contacts.removeAll(keepingCapacity: true)
        
        let request = Contact.fetchRequest()
        let alphabetSorter = NSSortDescriptor(key: #keyPath(Contact.fullname), ascending: true)
        request.sortDescriptors = [alphabetSorter]
        
        do {
            let results = try context.fetch(request) as [NSManagedObject]
            for result in results {
                contacts.append(result as! Contact)
            }
            self.contactsView.reloadData()
        }catch {
            print(error.localizedDescription)
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
        
        cell.fullName.text = contactAtPosition.fullname
        cell.phoneNumber.text = contactAtPosition.phonenumber
        
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
                $0.fullname?.lowercased().contains(searchText.lowercased()) ?? false || $0.phonenumber?.lowercased().contains(searchText.lowercased()) ?? false
            })
        }
        
        self.contactsView.reloadData()
    }
}
