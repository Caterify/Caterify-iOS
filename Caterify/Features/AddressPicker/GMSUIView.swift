//
//  GMSUIView.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI
import CoreLocation
import GoogleMaps

class GMSUIView: UIView {
    
    var parent: GMSUIViewRep?
    
    // Initialize the location manager.
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var preciseLocationZoomLevel: Float = 15.0
    var approximateLocationZoomLevel: Float = 10.0
    
    
    func initLocationManager() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func initMapView() {
        
        // Create a map.
        let zoomLevel = locationManager.accuracyAuthorization == .fullAccuracy ? preciseLocationZoomLevel : approximateLocationZoomLevel
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationCoordinate2D.defaultLocation.latitude,
                                              longitude: CLLocationCoordinate2D.defaultLocation.longitude,
                                              zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: self.bounds, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        
        // Add the map to the view, hide it until we've got a location update.
        self.addSubview(mapView)
        mapView.isHidden = true
    }
    
}


extension GMSUIView: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let zoomLevel = locationManager.accuracyAuthorization == .fullAccuracy ? preciseLocationZoomLevel : approximateLocationZoomLevel
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
    }
    
    // Handle authorization for the location manager.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let accuracy = manager.accuracyAuthorization
        let status = manager.authorizationStatus
        
        // Check accuracy authorization
        switch accuracy {
        case .fullAccuracy:
            print("Location accuracy is precise.")
        case .reducedAccuracy:
            print("Location accuracy is not precise.")
        default:
            fatalError()
        }
        
        // Handle authorization status
        switch status {
        case .restricted:
            print("Location access was restricted.")
            parent?.authorizationFailed = true
        case .denied:
            print("User denied access to location.")
            parent?.authorizationFailed = true
        case .notDetermined:
            print("Location status not determined.")
            parent?.authorizationFailed = false
        case .authorizedWhenInUse, .authorizedAlways:
            print("Location status is OK.")
            locationManager.startUpdatingLocation()
            parent?.authorizationFailed = false
        default:
            fatalError()
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
}

extension GMSUIView: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        
        let location: CLLocation = CLLocation(latitude: position.target.latitude, longitude: position.target.longitude)
        getAddressFromCooordinate(coordinate: location.coordinate)
        
    }
    
    func getAddressFromCooordinate(coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let error = error {
                print("Error Getting Address from Coordinate: \(error.localizedDescription)")
            } else {
                if let response = response,
                   let result = response.results()?.first {
                    self.parent?.location = result
                }
            }
        }
    }
    
}
