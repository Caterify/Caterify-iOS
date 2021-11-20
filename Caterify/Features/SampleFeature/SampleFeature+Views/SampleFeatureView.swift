//
//  SampleFeatureView.swift
//  Caterify
//
//  Created by Farrel Anshary on 19/11/21.
//

import SwiftUI

struct SampleFeatureView: View {
    @ObservedObject var sampleViewModel = SampleFeatureViewModel()
    
    var body: some View {
        NavigationView {
            List(sampleViewModel.provinces) { province in
                Text("\(province.name)")
            }
            .onAppear {
                sampleViewModel.getAllProvinces()
            }
            .redacted(reason: sampleViewModel.doneLoading ? [] : .placeholder)
            .navigationTitle(Text("Provinces"))
        }
    }
}

struct SampleFeatureView_Previews: PreviewProvider {
    static var previews: some View {
        SampleFeatureView()
    }
}
