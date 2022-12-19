//
//  ViewController.swift
//  TermProject
//
//  Created by Serkan Berk Bilgiç on 19.12.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        testLabel.text = "Text has changed"
    }


}

