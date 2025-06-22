//
//  CheckoutView.swift
//  coffeeApp
//
//  Created by Burak Selçuk on 22.06.2025.
//

import SwiftUI

struct CheckoutView: View {
    let total: Double
    let deliveryOption: DeliveryOption
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.green)
                
                Text("Order Received!")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Total: $\(String(format: "%.2f", total))")
                    .font(.headline)
                    .foregroundColor(.orange)
                
                Text(deliveryOption == .pickup ? "Your order will be ready in 15-20 minutes." : "Your order will be delivered to your address in 30-45 minutes.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Button("OK") {
                    presentationMode.wrappedValue.dismiss()
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.orange)
                .cornerRadius(15)
                .padding(.horizontal)
            }
            .navigationTitle("Order Confirmation")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

enum DeliveryOption: CaseIterable {
    case pickup
    case delivery
}

#Preview("Pickup Order") {
    CheckoutView(total: 24.50, deliveryOption: .pickup)
}

#Preview("Delivery Order") {
    CheckoutView(total: 32.75, deliveryOption: .delivery)
}
