//
//  AccountsViewController.swift
//  SideMenu
//
//  Created by Hiroshi Takemoto on 2/15/19.
//

import UIKit

class AccountTableViewController: UITableViewController {

    // MARK: Properties
    
    var user: User?
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUser()
        setSaveButton()
    }
    
    // MARK: Private Methods
    
    private func setUser() {
        if let user = user {
            firstNameTextField.insertText(user.firstName)
            lastNameTextField.insertText(user.lastName)
            emailTextField.insertText(user.email)
        }
    }
    
    private func setSaveButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    }
    
    @objc func saveButtonTapped(sender: UIBarButtonItem) {
        self.view.endEditing(true)
        
        // Declare Alert message
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to update?", preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "Update", style: .default, handler: { action in
            let firstName = self.firstNameTextField.text ?? ""
            let lastName = self.lastNameTextField.text ?? ""
            let email = self.emailTextField.text ?? ""
            self.user = User(firstName: firstName, lastName: lastName, email: email)
            self.performSegue(withIdentifier: "SaveUserSegue", sender: nil)
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }

}

extension AccountTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
