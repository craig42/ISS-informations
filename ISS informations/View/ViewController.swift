//
//  ViewController.swift
//  ISS informations
//
//  Created by Craig Josse on 26/06/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var peopleInSpace: UILabel!
    @IBOutlet var issUpcoming: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView.delegate = self
        print("TEST")
        
        
        let issPosition = IssPositionToView()
        issPosition.getIssPosition(callback: {
            coordinate in
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "ISS"
            DispatchQueue.main.async {
                self.mapView.addAnnotation(annotation)
                let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 100.0, longitudeDelta: 100.0))
                self.mapView.setRegion(region, animated: true)
            }

        })
    }

}

