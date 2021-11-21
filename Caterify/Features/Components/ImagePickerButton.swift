//
//  ImagePickerButton.swift
//  Caterify
//
//  Created by Joanda Febrian on 21/11/21.
//

import SwiftUI

struct ImagePickerButton: View {
    
    @Binding var image: UIImage?
    
    var body: some View {
        ZStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, minHeight: 100, idealHeight: 100, maxHeight: 100)
                    .cornerRadius(6)
                    .clipped()
            } else {
                Image(uiImage: UIImage(systemName: "photo.on.rectangle.angled")!)
                    .renderingMode(.template)
                    .foregroundColor(.main)
                    .frame(maxWidth: .infinity, minHeight: 100, idealHeight: 100, maxHeight: 100)
                    .background(.ultraThinMaterial)
                    .cornerRadius(6)
                    .clipped()
            }
        }
    }
}

struct ImagePickerButton_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerButton(image: .constant(nil))
    }
}
