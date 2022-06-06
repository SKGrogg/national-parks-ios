//
//  ParkCell.swift
//  NationalParks
//
//  Created by Sean Grogg on 4/4/22.
//

import UIKit

class ParkCell: UITableViewCell {
    
    
    
    @IBOutlet weak var parkNameLabel: UILabel!
    @IBOutlet weak var parkStateLabel: UILabel!
    @IBOutlet weak var parkImageView: UIImageView!
    
    var park: Park? {
        
        didSet {
            
            
            let swiftColor = UIColor.systemMint.withAlphaComponent(0.5)//UIColor(red: 0, green: 0.8, blue: 0.3, alpha: 0.5)
            
            self.parkNameLabel.text = park?.name
            self.parkStateLabel.text = "State: " + park!.state
            self.accessoryType = park!.confirmedVisit ? .checkmark : .none
            self.backgroundColor = park!.confirmedFavorite ? swiftColor : .none
            
            DispatchQueue.global(qos: .userInitiated).async {
                let parkImageData =
                NSData(contentsOf:
                        URL(string:
                                self.park!.imageURL)!)
                DispatchQueue.main.async {
                    self.parkImageView.image = UIImage(data: parkImageData as! Data)
                    self.parkImageView.layer.cornerRadius =
                    self.parkImageView.frame.width / 2
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
