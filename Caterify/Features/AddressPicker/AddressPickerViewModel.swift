//
//  AddressPickerViewModel.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import Foundation
import GoogleMaps
import SwiftUI

final class AddressPickerViewModel: ObservableObject {
    
    @Published var location: GMSAddress?
    @Published var addressNotes: String = ""
    @Published var authorizationFailed: Bool = false
    
    @AppStorage("address") var savedAddress: String = "Address Not Set"
    @AppStorage("locality") var savedLocality: String = ""
    @AppStorage("latitude") var latitude: CLLocationDegrees = 0.0
    @AppStorage("longitude") var longitude: CLLocationDegrees = 0.0
    @AppStorage("addressNotes") var savedAddressNotes: String = ""
    
    init() {
        self.addressNotes = savedAddressNotes
    }
    
    var address: String? {
        if let location = location, let address = location.thoroughfare {
            return location.coordinate.isDefaultLocation ? nil : address
        }
        return nil
    }
    
    var area: String? {
        if let location = location {
            if location.coordinate.isDefaultLocation {
                return nil
            } else {
                var area = ""
                if let locality = location.locality {
                    area.append("\(locality), ")
                }
                if let administrativeArea = location.administrativeArea, let postalCode = location.postalCode {
                    area.append("\(administrativeArea) \(postalCode)")
                }
                return area
            }
        }
        return nil
    }
    
}
