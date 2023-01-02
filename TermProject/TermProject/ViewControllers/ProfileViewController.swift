//
//  ProfileViewController.swift
//  TermProject
//
//  Created by Eren Ceylan on 2.01.2023.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var surnameLabel: UILabel!
    
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Profile"
        
    }
    
    
    @IBAction func logoutClicked(_ sender: Any) {
        print("log out")
        
        do {
            try Auth.auth().signOut()
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "RegisterNavigationController") as? UINavigationController {
                self.view.window?.rootViewController = viewController
                self.view.window?.makeKeyAndVisible()
            }
        } catch {
            
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
