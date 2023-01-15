//
//  SettingsViewController.swift
//  TermProject
//
//  Created by Eren Ceylan on 15.01.2023.
//

import UIKit
import Firebase
import FirebaseFirestore

class SettingsViewController: UIViewController {

    
 
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var surnameTF: UITextField!
    
    
    @IBOutlet weak var infoLabel: UILabel!
    
    
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveChangesTapped(_ sender: Any) {
        if let name = nameTF.text {
            if name.isEmpty == false{
                db.collection("users").document(Auth.auth().currentUser?.uid ?? "").updateData([
                   "firstName": name
                ]) { err in
                    if let err = err {
                        print("An error occured")
                    }else {
                        print("Successfully updated    ")
                    }
                }
            }
           
        }
        
        if let surname = surnameTF.text {
            
            if surname.isEmpty == false {
                db.collection("users").document(Auth.auth().currentUser?.uid ?? "").updateData([
                   "lastName": surname
                ]) { err in
                    if let err = err {
                        print("An error occured")
                    }else {
                        print("Successfully updated    ")
                    }
                }
            }
            
        }
    }
   
    @IBAction func resetPasswordDidTapped(_ sender: Any) {
        
        let email = Auth.auth().currentUser?.email as! String
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                print("Error occured")
            }else {
                self.infoLabel.text = "Reset password email sent to your email adress"
                self.infoLabel.alpha = 1
                self.infoLabel.textColor = .blue
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
