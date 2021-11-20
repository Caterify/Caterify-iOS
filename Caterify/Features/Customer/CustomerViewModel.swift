//
//  CustomerViewModel.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI
import CoreLocation
import Combine

final class CustomerViewModel: ObservableObject {
    
    @Published var orders: [Order] = []
    @Published var featured: [Catering] = []
    @Published var nearby: [Catering] = []
    @Published var affordable: [Catering] = []
    @Published var doneLoadingFeature = false
    
    private let cateringRequest = CateringRequest()
    private var cancellable = Set<AnyCancellable>()
    
    @AppStorage("latitude") var latitude: CLLocationDegrees = .defaultLat
    @AppStorage("longitude") var longitude: CLLocationDegrees = .defaultLng
    
    func getFeatured() {
        doneLoadingFeature = false
        cateringRequest.getFeaturedCaterings(lat: latitude, long: longitude)
            .receive(on: DispatchQueue.main, options: nil)
            .sink { result in
                switch result {
                case .finished:
                    print("Finished!")
                case .failure(let err):
                    print("Error Fetching Caterings: \(err.message!)")
                }
            } receiveValue: { [weak self] responses in
                guard let data = responses.data else { return }
                let caterings = data.caterings
                self?.featured = caterings
                self?.nearby = caterings.sorted { $0.distance! < $1.distance! }
                self?.affordable = caterings.sorted { $0.averagePrice! < $1.averagePrice!}
                self?.doneLoadingFeature = true
            }
            .store(in: &cancellable)

    }
}
