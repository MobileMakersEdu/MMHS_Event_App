//
//  ExploreViewController.swift
//  MMHS_Event_App
//
//  Created by Johnny Appleseed on 9/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import UIKit

import MapKit
import CoreLocation

class ExploreViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!

    var currentLocation = CLLocation()
    let locationManager = CLLocationManager()

    var eventsArray = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        mapView.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    override func viewWillAppear(animated: Bool) {
        getAllEvents { (events, result, error) -> Void in
            for event in events
            {
                self.addPins(ofRecord: event, image: imageFromAsset(event.eventPhoto))
            }
        }
    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        for location in locations as [CLLocation]
        {
            if location.verticalAccuracy < 1000 && location.horizontalAccuracy < 1000
            {
                locationManager.stopUpdatingLocation()
            mapView.setRegion(MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.1, 0.1)), animated: true)
            }
        }
    }

    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        let annot = annotation as EventAnnotation
        let annotView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)

        let resizedImage = annot.pic.compressImageAndResize(CGSizeMake(65, 65)) as UIImage!
        annotView.image = resizedImage
        annotView.layer.cornerRadius = annotView.image.size.height / 2
        annotView.clipsToBounds = true

        return annotView
    }

    func addPins(ofRecord record: Event, image : UIImage)
    {
        var pin = EventAnnotation()
        pin.coordinate = record.location.coordinate
        pin.pic = image
        mapView.addAnnotation(pin)
    }
}
