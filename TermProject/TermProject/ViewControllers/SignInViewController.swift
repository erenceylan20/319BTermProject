//
//  SignInViewController.swift
//  TermProject
//
//  Created by Eren Ceylan on 2.01.2023.
//

import UIKit
import Firebase
import FirebaseFirestore
class SignInViewController: UIViewController {

    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    
    @IBOutlet weak var signinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    func setUpElements () {
        errorLabel.alpha = 0
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleTextField(nameTextField)
        Utilities.styleTextField(surnameTextField)
        Utilities.styleFilledButton(signinButton)
    }
    @IBAction func signIn(_ sender: Any) {
        
//        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
//            surnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
//            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
//            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
//            showError("Please fill in all the fields!")
//        }
        
        
        guard let name = nameTextField.text else
            {return}
        guard let surname = surnameTextField.text else {return}
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
       
        Auth.auth().createUser(withEmail: email, password: password) { firebaseResult, error in
            if let e = error {
                self.showError("An error occured while creating the user")
                print("error")
            } else {
                
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: ["firstName": name, "lastName": surname, "uid": firebaseResult!.user.uid]) { err in
                    if err != nil {
                        self.showError("Error saving user data")
                    }
                }
                
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
                    self.view.window?.rootViewController = viewController
                    self.view.window?.makeKeyAndVisible()
                }
            }
        }
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
