//
//  SampleFeatureViewModel.swift
//  Caterify
//
//  Created by Farrel Anshary on 19/11/21.
//

import Foundation
import Combine

class SampleFeatureViewModel: ObservableObject {
    @Published var provinces = Dummies.provinces
    @Published var doneLoading = false
    
    private let sampleRequest = SampleRequest()
    private var cancellable = Set<AnyCancellable>()
    
    func getAllProvinces() {
        self.doneLoading = false
        self.provinces = Dummies.provinces
        sampleRequest
            .getAllProvinces()
            .receive(on: DispatchQueue.main, options: nil)
            .sink { result in
                switch result {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("Debug sample: \(error.message!)")
                }
            } receiveValue: { [weak self] responses in
                guard let data = responses.data else { return }
                self?.provinces = data.provinces;
                self?.doneLoading = true
            }
            .store(in: &cancellable)
    }
}
