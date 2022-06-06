//
//  MapViewController.swift
//  NationalParks
//
//  Created by Sean Grogg on 5/19/22.
//

// Assistance with understanding how to implement the map view came from fellow MPCS Student Elizabeth Ng
// Elizabeth allowed me to look at an app she had made that implemented a MapView to get an understanding of the concepts

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    var parks: [Park] = []
    var parkService: ParkService!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.parkService = ParkService()
        mapView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

        
        self.parkService.getParks(completion: {parks, error in
            guard let parks = parks, error == nil else {
                print("error happened here")
                return
            }
            self.parks = parks
            //Apple Documentation: https://developer.apple.com/documentation/mapkit/mkmapview/1451889-addannotations
            self.mapView.addAnnotations(self.createAnnotationList(parks: self.parks))
        })
    }
    //Apple Documentation on MKPointAnnotations: https://developer.apple.com/documentation/mapkit/mkpointannotation
    //Tutorial I looked at to help understand further: https://www.hackingwithswift.com/example-code/location/how-to-add-annotations-to-mkmapview-using-mkpointannotation-and-mkpinannotationview
    func createAnnotationList(parks: [Park]) -> [MKPointAnnotation]{
        var anns: [MKPointAnnotation] = []
        for park in parks{
            var ann: MKPointAnnotation = MKPointAnnotation()
            ann.coordinate = park.coordinate
            ann.title = park.name
            anns.append(ann)
        }
        return anns
        
    }
    

    

}
