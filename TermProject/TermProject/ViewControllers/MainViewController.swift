//
//  ViewController.swift
//  TermProject
//
//  Created by Serkan Berk Bilgiç on 19.12.2022.
//

import UIKit

class MainViewController: UIViewController, UITabBarDelegate {

    
    
    
    @IBOutlet weak var eventListTableView: UITableView!
    

    @IBOutlet weak var addUIBarButtonItem: UIBarButtonItem!
    
    
    
    let eventDataSource = EventDataSource()
    
    @IBOutlet weak var testLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.items?[0].image = UIImage(systemName: "house.fill")
        self.tabBarController?.tabBar.items?[1].image = UIImage(systemName: "book.fill")
        //self.tabBarController?.tabBar.items?[2].image = UIImage(systemName: "person.fill")
        self.tabBarController?.tabBar.items?[0].title = "Events"
        self.tabBarController?.tabBar.items?[1].title = "Courses"
        //self.tabBarController?.tabBar.items?[2].title = "Profile"
        
        self.title = "Events"
        eventDataSource.delegate = self
        
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let cell = sender as? EventTableViewCell,
           let indexPath = eventListTableView.indexPath(for: cell),
           let event = eventDataSource.getEvent(for: indexPath.row),
           let detailController = segue.destination as? EventDetailViewController {
            detailController.eventID = event.id
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if(item.tag == 1) {
            
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            if let nextViewController = storyBoard.instantiateViewController(withIdentifier: "coursesPage") as? CoursesViewController {
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.pushViewController(nextViewController, animated: true)
                //self.navigationController?.popToViewController(nextViewController, animated: true)
                
            }
           
        } else if(item.tag == 2) {
            // Open Profile Page
        }
    }

}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventDataSource.getNumberOfEvents()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as? EventTableViewCell else {
            return UITableViewCell()
        }
        
        if let event = eventDataSource.getEvent(for: indexPath.row) {
            cell.hostLabel.text = "\(event.hostName) \(event.hostSurname)"
            cell.titleLabel.text = "\(event.title)"
            cell.placeLabel.text = "\(event.place)"
            
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm - dd/MM"
            //let beginningTime = formatter.string(from: event.beginningTime)
            //let endingTime = formatter.string(from: event.endingTime)
            
            cell.typeImageView.image = UIImage(named: event.eventType)
        
        } else {
            cell.hostLabel.text = ""
            cell.titleLabel.text = ""
            cell.placeLabel.text = ""
        }
        
        return cell
    }
    
    
}

extension MainViewController: EventDataDelegate {
    func eventListUpdated() {
        self.eventListTableView.reloadData()
    }
}
