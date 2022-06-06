//
//  ParkDetail.swift
//  NationalParks
//
//  Created by Sean Grogg on 4/19/22.
//

import UIKit

class ParkDetail: UIView {

    @IBOutlet weak var parkImageView: UIImageView!
    @IBOutlet weak var parkLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var foundedLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var park: Park? {
        didSet{
            self.parkLabel.text = park?.name
            self.stateLabel.text = park?.state
            self.descriptionLabel.text = park?.description
            self.foundedLabel.text = park?.yearFounded
            self.sizeLabel.text = park?.size
            
            DispatchQueue.global(qos: .userInitiated).async {
                let parkImageData =
                NSData(contentsOf:
                        URL(string:
                                self.park!.imageURL)!)
                DispatchQueue.main.async {
                    self.parkImageView.image = UIImage(data: parkImageData as! Data)
                }
            }
        }
    }

}
