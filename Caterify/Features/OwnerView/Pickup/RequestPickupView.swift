//
//  RequestPickupView.swift
//  Caterify
//
//  Created by Farrel Anshary on 21/11/21.
//

import SwiftUI

struct RequestPickupView: View {
    @State var isPickupConfirmed: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 24){
            if !isPickupConfirmed {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(4, anchor: .center)
                    .tint(.main)
                    .frame(width: 100, height: 100)
                Text("Requesting Pickup...")
                    .font(.headline)
                    .foregroundColor(.primary)
            } else {
                Image(systemName: "checkmark.seal.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.green)
                Text("Pickup Confirmed")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                isPickupConfirmed = true
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                    self.dismiss()
                }
            }
        }
    }
}

struct RequestPickupView_Previews: PreviewProvider {
    static var previews: some View {
        RequestPickupView()
    }
}
