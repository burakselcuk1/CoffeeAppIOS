//
//  PaymentMethodView.swift
//  coffeeApp
//
//  Created by Burak Selçuk on 22.06.2025.
//

import SwiftUI

struct PaymentMethodView: View {
    @Binding var selectedMethod: PaymentMethod
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                ForEach(PaymentMethod.allCases, id: \.self) { method in
                    Button(action: {
                        selectedMethod = method
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: method.icon)
                                .foregroundColor(.orange)
                            
                            VStack(alignment: .leading) {
                                Text(method.title)
                                    .foregroundColor(.primary)
                                Text(method.subtitle)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            if selectedMethod == method {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.orange)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Ödeme Yöntemi")
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

enum PaymentMethod: CaseIterable {
    case card
    case cash
    case applePay
    
    var title: String {
        switch self {
        case .card: return "Kredi/Banka Kartı"
        case .cash: return "Nakit"
        case .applePay: return "Apple Pay"
        }
    }
    
    var subtitle: String {
        switch self {
        case .card: return "**** 1234"
        case .cash: return "Teslimat sırasında ödeme"
        case .applePay: return "Touch ID ile öde"
        }
    }
    
    var icon: String {
        switch self {
        case .card: return "creditcard.fill"
        case .cash: return "banknote"
        case .applePay: return "applelogo"
        }
    }
}

#Preview("Credit Card Selected") {
    PaymentMethodView(selectedMethod: .constant(.card))
}

#Preview("Cash Selected") {
    PaymentMethodView(selectedMethod: .constant(.cash))
}

#Preview("Apple Pay Selected") {
    PaymentMethodView(selectedMethod: .constant(.applePay))
}
