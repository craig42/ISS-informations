//
//  MainView.swift
//  ISS informations
//
//  Created by Craig Josse on 26/06/2020.
//  Copyright © 2020 Craig Josse. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var peopleInSpaceLabel: UILabel!
    @IBOutlet var issUpcoming: UILabel!
    var timer = Timer()
    // https://github.com/public-apis/public-apis
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        timer = Timer.scheduledTimer(withTimeInterval: 15, repeats: true) {_ in
            self.updateISSPosition()
            self.updateNumberOfPeopleInSpace()
            self.updateIssPassTime()
        }
        timer.fire()
    }
    func updateISSPosition() {
        let issPosition = IssPositionToView()
        issPosition.getIssPosition(callback: { coordinate in
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "ISS"
            DispatchQueue.main.async {
                self.mapView.addAnnotation(annotation)
                let region = MKCoordinateRegion(center:
                    CLLocationCoordinate2D(latitude: coordinate.latitude,
                                           longitude: coordinate.longitude),
                                                span: MKCoordinateSpan(latitudeDelta: 100.0, longitudeDelta: 100.0))
                self.mapView.setRegion(region, animated: true)
            }
        })
    }
    func updateNumberOfPeopleInSpace() {
        let peopleInSpace = PeopleInSpaceToView()
        peopleInSpace.getPeopleInSpace(callback: { peopleText in
            DispatchQueue.main.async {
                self.peopleInSpaceLabel.text = peopleText
                let numberOfLines = peopleText.components(separatedBy: "\n")
                self.peopleInSpaceLabel.numberOfLines = numberOfLines.count
            }
        })
    }
    func updateIssPassTime() {
        let issPassTime = IssPassTimesToView()
        issPassTime.getIssPassTimes(callback: { passTimeText in
            DispatchQueue.main.async {
                self.issUpcoming.text = passTimeText
                let numberOfLines = passTimeText.components(separatedBy: "\n")
                self.issUpcoming.numberOfLines = numberOfLines.count
            }
        })
    }
}
