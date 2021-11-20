//
//  Extension+CLLocationCoordinate2D.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import CoreLocation

extension CLLocationCoordinate2D {
    
    // A default location to use when location permission is not granted.
    static let defaultLocation = CLLocationCoordinate2D(latitude: .defaultLat, longitude: .defaultLng)
    
    var isDefaultLocation: Bool {
        return self.latitude == CLLocationCoordinate2D.defaultLocation.latitude && self.longitude == CLLocationCoordinate2D.defaultLocation.longitude ? true : false
    }
    
}

extension CLLocationDegrees {
    static let defaultLat = -6.175399974396614
    static let defaultLng = 106.82720001786946
}
