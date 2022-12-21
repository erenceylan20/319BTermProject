//
//  ViewController.swift
//  TermProject
//
//  Created by Serkan Berk Bilgiç on 19.12.2022.
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet weak var eventListTableView: UITableView!
    
    @IBOutlet weak var testLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        testLabel.text = "New Text"
        self.title = "Events"
    }


}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as? EventTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    
}
