//
//  GMSUIViewRep.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI
import GoogleMaps

struct GMSUIViewRep: UIViewRepresentable {
    
    @Binding var location: GMSAddress?
    @Binding var authorizationFailed: Bool
    
    typealias UIViewType = GMSUIView
    
    func makeUIView(context: Context) -> GMSUIView {
        let mapsVC = GMSUIView()
        mapsVC.initLocationManager()
        mapsVC.initMapView()
        mapsVC.parent = self
        return mapsVC
    }
    
    func updateUIView(_ uiView: GMSUIView, context: Context) {
        
    }
    
}

