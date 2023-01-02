//
//  SignInViewController.swift
//  TermProject
//
//  Created by Eren Ceylan on 2.01.2023.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signIn(_ sender: Any) {
        
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        
        Auth.auth().createUser(withEmail: email, password: password) { firebaseResult, error in
            if let e = error {
                print("error")
            } else {
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
                    self.view.window?.rootViewController = viewController
                    self.view.window?.makeKeyAndVisible()
                }
            }
        }
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
