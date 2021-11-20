//
//  CustomForm.swift
//  Caterify
//
//  Created by Meichel Rendio on 20/11/21.
//

import SwiftUI

struct CustomForm: View {
    
    enum FormType {
        case normal, secure, numeric
    }
    
    let placeholder:String
    let title:String
    let type: FormType
    @Binding var field: String
    @Binding var isError: Bool
    @Binding var errorDescription: String
    
    var body: some View {
        switch type {
        case .normal:
            VStack(alignment: .leading, spacing: 8){
                Text(title)
                    .font(.caption)
                TextField(placeholder, text: $field)
                    .padding(14)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(.ultraThinMaterial)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(isError ? .red : Color.ultraLightGrey)
                    )
                    .contentShape(Rectangle())
                    .onChange(of: $field.wrappedValue) { newValue in
                        if isError {
                            isError = false
                        }
                    }
                if isError{
                    Text(errorDescription)
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
        case .secure:
            VStack(alignment: .leading, spacing: 8){
                Text(title)
                    .font(.caption)
                SecureField(placeholder, text: $field)
                    .padding(14)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(.ultraThinMaterial)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(isError ? .red : Color.ultraLightGrey)
                    )
                    .contentShape(Rectangle())
                    .onChange(of: $field.wrappedValue) { newValue in
                        if isError {
                            isError = false
                        }
                    }
                if isError{
                    Text(errorDescription)
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
        case .numeric:
            VStack(alignment: .leading, spacing: 8){
                Text(title)
                    .font(.caption)
                TextField(placeholder, text: $field)
                    .keyboardType(.numberPad)
                    .padding(14)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(.ultraThinMaterial)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(isError ? .red : Color.ultraLightGrey)
                    )
                    .contentShape(Rectangle())
                    .onChange(of: $field.wrappedValue) { newValue in
                        if isError {
                            isError = false
                        }
                    }
                if isError{
                    Text(errorDescription)
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
        }
    }
}
