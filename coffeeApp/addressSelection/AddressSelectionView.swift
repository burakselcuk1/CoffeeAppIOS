//
//  AddressSelectionView.swift
//  coffeeApp
//
//  Created by Burak Selçuk on 22.06.2025.
//

import SwiftUI

struct AddressSelectionView: View {
    @Binding var selectedAddress: String
    @Environment(\.presentationMode) var presentationMode
    
    let addresses = ["Home Address", "Work Address", "Mom's House"]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(addresses, id: \.self) { address in
                    Button(action: {
                        selectedAddress = address
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(address)
                                    .foregroundColor(.primary)
                                Text("123 Main Street, Downtown District")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            if selectedAddress == address {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.orange)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Select Address")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

#Preview("No Selection") {
    AddressSelectionView(selectedAddress: .constant(""))
}

#Preview("Home Selected") {
    AddressSelectionView(selectedAddress: .constant("Home Address"))
}

#Preview("Work Selected") {
    AddressSelectionView(selectedAddress: .constant("Work Address"))
}
