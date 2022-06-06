//
//  ViewController.swift
//  NationalParks
//
//  Created by Sean Grogg on 4/4/22.
//

import UIKit

class ParkListViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var nameSortButton: UIButton!
    @IBOutlet weak var stateSortButton: UIButton!
    
    
    var window: UIWindow? {
            guard let scene = UIApplication.shared.connectedScenes.first,
                  let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
                  let window = windowSceneDelegate.window else {
                return nil
            }
            return window
        }
    
    
    
    var parks: [Park] = []
    var parkService: ParkService!
    
    var spinner = UIActivityIndicatorView(style: .gray)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.parkService = ParkService()
            
        self.tableView.dataSource = self
        self.tableView.delegate = self

        

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let confirmedService = self.parkService else { return }
        
        self.spinner.translatesAutoresizingMaskIntoConstraints = false
        self.spinner.startAnimating()
        self.view.addSubview(spinner)
                
        self.spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        self.parkService.getParks(completion: {parks, error in
            guard let parks = parks, error == nil else {
                return self.showAPIProblemAlert()
            }
            self.parks = parks
            self.tableView.reloadData()
            self.spinner.stopAnimating()
            
            if (self.parks.count == 0) {
                self.showEmptyListAlert()
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destination = segue.destination as? DetailViewController,
            let selectedIndexPath = self.tableView.indexPathForSelectedRow,
            let confirmedCell = self.tableView.cellForRow(at: selectedIndexPath) as? ParkCell
            else { return }
    
        let confirmedPark = confirmedCell.park
        destination.park = confirmedPark
        
    }
    
    func showEmptyListAlert() {
        let alert = UIAlertController(title: "Empty List", message: "Sorry, it seems that there are no parks to load today. I hope they're okay!", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in print("User Confirmed")}))
        self.present(alert, animated: true, completion: nil)
        }
    
    func showAPIProblemAlert() {
        let alert = UIAlertController(title: "API Error", message: "Sorry, it seems we're having trouble pulling the data from our API.", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in print("User Confirmed")}))
        self.present(alert, animated: true, completion: nil)
        }
    
    //Used this tutorial to better understand how to manipulate Interface Style
    //https://sarunw.com/posts/how-to-disable-dark-mode-in-ios/
    @IBAction func switchDidChange (_ sender: UISwitch){
        
        if sender.isOn {
            self.window?.overrideUserInterfaceStyle = .light
        }else {
            self.window?.overrideUserInterfaceStyle = .dark
        }
    }
    
    
    @IBAction func sortByName(_ sender: UIButton) {
        self.parks.sort(by: {$0.name < $1.name})
        self.tableView.reloadData()
    }
    
    
    @IBAction func sortByState(_ sender: UIButton) {
        self.parks.sort(by: {$0.state < $1.state})
        self.tableView.reloadData()
    }
    
    

}

extension ParkListViewController: UITableViewDataSource {
    
    // MARK: DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.parks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =
            self.tableView.dequeueReusableCell(withIdentifier: "parkCell") as! ParkCell
        
        
        let currentPark = self.parks[indexPath.row]
        cell.park = currentPark
        
        return cell
        
    }
    
}

extension ParkListViewController: UITableViewDelegate {
    
    // MARK: Delegate
     
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //this all seems to be working
        if
            let cell = self.tableView.cellForRow(at: indexPath) as? ParkCell,
            let confirmedPark = cell.park
        {
            
            // Get current state from data source
            let favorite = confirmedPark.confirmedFavorite
            
            let title = favorite ? "Unfavorite" : "Favorite"

            let action = UIContextualAction(style: .normal, title: title,
                handler: { (action, view, completionHandler) in
                
                confirmedPark.confirmedFavorite = !favorite
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
                completionHandler(true)
              })

                action.backgroundColor = favorite ? .systemRed : .systemMint
                let configuration = UISwipeActionsConfiguration(actions: [action])
                return configuration
        }

        return nil //just to get it to build
    }
}

