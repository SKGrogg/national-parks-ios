//
//  DetailViewController.swift
//  NationalParks
//
//  Created by Sean Grogg on 4/13/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    var park: Park!

    @IBOutlet var parkDetail: ParkDetail!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.parkDetail.park = self.park
            
        }
        
    //This video tutorial showed me how to use a button to trigger the segue
    //https://www.youtube.com/watch?v=DxCydBmOqXU
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destination = segue.destination as? PDFViewController
            else { return }
        let confirmedPark = self.park
        destination.park = confirmedPark
    
    }
}

    

