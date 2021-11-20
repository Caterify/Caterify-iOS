//
//  PaymentLoadingView.swift
//  Caterify
//
//  Created by Meichel Rendio on 20/11/21.
//

import SwiftUI

struct PaymentLoadingView: View {
    
    @State var isPaymentConfirmed: Bool = false
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 24){
            if !isPaymentConfirmed {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(4, anchor: .center)
                    .tint(.main)
                    .frame(width: 100, height: 100)
                Text("Confirming Payment...")
                    .font(.headline)
                    .foregroundColor(.primary)
            } else {
                Image(systemName: "checkmark.seal.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.green)
                Text("Payment Complete")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                isPaymentConfirmed = true
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                    isPresented.toggle()
                }
            }
        }
    }
}
