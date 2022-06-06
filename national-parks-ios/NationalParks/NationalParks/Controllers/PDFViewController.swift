//
//  PDFViewController.swift
//  NationalParks
//
//  Created by Sean Grogg on 5/25/22.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController{
    
    var park: Park!
    
    @IBOutlet weak var scrollView: UIScrollView!
    //A helpful walkthrough of how to set UIImageView size parameter
    //https://roadfiresoftware.com/2015/03/how-to-get-an-image-to-fill-an-image-view-without-any-clipping/
    @IBOutlet weak var hikingImage: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
              
        scrollView.delegate = self
        DispatchQueue.global(qos: .userInitiated).async {
            let hikingImageData =
            NSData(contentsOf:
                    URL(string:
                            self.park!.hikingURL)!)
            DispatchQueue.main.async {
                self.hikingImage.image = UIImage(data: hikingImageData as! Data)
            }
        }
        
    }
    
    
    
}

//I used these tutorial to implement the zoom on the scrollView
//https://letcreateanapp.com/2021/05/20/pinch-to-zoom-image-in-out-programmatically/
//https://www.raywenderlich.com/5758454-uiscrollview-tutorial-getting-started
extension PDFViewController: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return hikingImage
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
             if scrollView.zoomScale > 1 {
                 if let image = hikingImage.image {
                     let ratioW = hikingImage.frame.width / image.size.width
                     let ratioH = hikingImage.frame.height / image.size.height
                     
                     let ratio = ratioW < ratioH ? ratioW : ratioH
                     let newWidth = image.size.width * ratio
                     let newHeight = image.size.height * ratio
                     let conditionLeft = newWidth*scrollView.zoomScale > hikingImage.frame.width
                     let left = 0.5 * (conditionLeft ? newWidth - hikingImage.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
                     let conditionTop = newHeight*scrollView.zoomScale > hikingImage.frame.height
                     
                     let top = 0.5 * (conditionTop ? newHeight - hikingImage.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
                     
                     scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
                     
                 }
             } else {
                 scrollView.contentInset = .zero
             }
         }
        
}
 
 
