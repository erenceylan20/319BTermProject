//
//  LoginViewController.swift
//  TermProject
//
//  Created by Serkan Berk Bilgiç on 31.12.2022.
//

import UIKit
import Firebase
import FirebaseAuth
class LoginViewController: UIViewController {

    @IBOutlet weak var loginPasswordTextField: UITextField!
    
    @IBOutlet weak var loginEmailTextField: UITextField!
    
    @IBOutlet weak var loginErrorLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBOutlet weak var signupButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    
    func setUpElements () {
        
        loginErrorLabel.alpha = 0
        
        
        Utilities.styleTextField(loginEmailTextField)
        Utilities.styleTextField(loginPasswordTextField)
        Utilities.styleFilledButton(loginButton)
        Utilities.styleHollowButton(signupButton)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func loginButtonTapped(_ sender: Any) {
        
        if let email = loginEmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           let password = loginPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            Auth.auth().signIn(withEmail: email, password: password) { result, err in
                if err != nil {
                    self.loginErrorLabel.text = err!.localizedDescription
                    self.loginErrorLabel.alpha = 1
                }else {
                    self.transitionToTheHomeScreen()
                }
            }
        }else {
            self.loginErrorLabel.text = "Wrong email or password"
            self.loginErrorLabel.alpha = 1
        }
        
        
    }
    func transitionToTheHomeScreen() {
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? MainViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
}
