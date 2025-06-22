//
//  CartView.swift
//  coffeeApp
//
//  Created by Burak Selçuk on 22.06.2025.
//
import SwiftUI

struct CartView: View {
    @State private var cartItems: [CartItem] = [
        CartItem(id: 1, name: "Cappuccino", description: "Espresso, steamed milk and milk foam", price: 32.00, quantity: 2, image: "cup.and.saucer.fill", size: "Medium", extras: ["Extra Shot", "Dairy-Free"]),
        CartItem(id: 2, name: "Americano", description: "Simple espresso and hot water", price: 25.00, quantity: 1, image: "cup.and.saucer.fill", size: "Large", extras: []),
        CartItem(id: 3, name: "Tiramisu", description: "Traditional Italian dessert", price: 45.00, quantity: 1, image: "birthday.cake.fill", size: "Regular", extras: ["Extra Cocoa"]),
        CartItem(id: 4, name: "Cold Brew", description: "12-hour steeped cold coffee", price: 30.00, quantity: 2, image: "cup.and.saucer", size: "Medium", extras: ["Vanilla Syrup"])
    ]
    
    @State private var deliveryOption = DeliveryOption.pickup
    @State private var selectedAddress = "Home Address"
    @State private var paymentMethod = PaymentMethod.card
    @State private var promoCode = ""
    @State private var isPromoApplied = false
    @State private var showingCheckout = false
    @State private var showingAddressSelection = false
    @State private var showingPaymentMethods = false
    
    let deliveryFee: Double = 15.00
    let serviceFee: Double = 5.00
    let promoDiscount: Double = 10.00
    
    var subtotal: Double {
        cartItems.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }
    
    var total: Double {
        var total = subtotal
        
        if deliveryOption == .delivery {
            total += deliveryFee
        }
        
        total += serviceFee
        
        if isPromoApplied {
            total -= promoDiscount
        }
        
        return max(total, 0)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if cartItems.isEmpty {
                    EmptyCartView()
                } else {
                    ScrollView {
                        VStack(spacing: 20) {
                            
                            VStack(spacing: 15) {
                                ForEach(cartItems) { item in
                                    CartItemCard(
                                        item: item,
                                        onQuantityChanged: { newQuantity in
                                            updateQuantity(for: item.id, quantity: newQuantity)
                                        },
                                        onRemove: {
                                            removeItem(id: item.id)
                                        }
                                    )
                                }
                            }
                            .padding(.horizontal)
                            
                            
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Delivery Option")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .padding(.horizontal)
                                
                                VStack(spacing: 0) {
                                    DeliveryOptionRow(
                                        option: .pickup,
                                        selectedOption: $deliveryOption,
                                        title: "Pickup",
                                        subtitle: "15-20 minutes • Free",
                                        icon: "bag"
                                    )
                                    
                                    Divider()
                                    
                                    DeliveryOptionRow(
                                        option: .delivery,
                                        selectedOption: $deliveryOption,
                                        title: "Delivery",
                                        subtitle: "30-45 minutes • $\(String(format: "%.0f", deliveryFee))",
                                        icon: "scooter"
                                    )
                                }
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
                                .padding(.horizontal)
                            }
                            
                         
                            if deliveryOption == .delivery {
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("Delivery Address")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .padding(.horizontal)
                                    
                                    Button(action: {
                                        showingAddressSelection = true
                                    }) {
                                        HStack {
                                            Image(systemName: "location.fill")
                                                .foregroundColor(.orange)
                                            
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(selectedAddress)
                                                    .font(.body)
                                                    .foregroundColor(.primary)
                                                
                                                Text("123 Main Street, Downtown District")
                                                    .font(.caption)
                                                    .foregroundColor(.secondary)
                                            }
                                            
                                            Spacer()
                                            
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.gray)
                                        }
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(15)
                                        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            
                          
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Promo Code")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .padding(.horizontal)
                                
                                HStack {
                                    TextField("Enter promo code", text: $promoCode)
                                        .textFieldStyle(PlainTextFieldStyle())
                                    
                                    Button(action: {
                                        applyPromoCode()
                                    }) {
                                        Text(isPromoApplied ? "Applied" : "Apply")
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .foregroundColor(isPromoApplied ? .green : .orange)
                                    }
                                    .disabled(promoCode.isEmpty || isPromoApplied)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
                                .padding(.horizontal)
                                
                                if isPromoApplied {
                                    HStack {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.green)
                                        Text("$\(String(format: "%.0f", promoDiscount)) discount applied")
                                            .font(.subheadline)
                                            .foregroundColor(.green)
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            
                           
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Payment Method")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .padding(.horizontal)
                                
                                Button(action: {
                                    showingPaymentMethods = true
                                }) {
                                    HStack {
                                        Image(systemName: paymentMethod.icon)
                                            .foregroundColor(.orange)
                                        
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(paymentMethod.title)
                                                .font(.body)
                                                .foregroundColor(.primary)
                                            
                                            Text(paymentMethod.subtitle)
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.gray)
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.bottom, 120)
                    }
                    
                 
                    VStack(spacing: 0) {
                        Divider()
                        
                        VStack(spacing: 15) {
                         
                            VStack(spacing: 8) {
                                PriceRow(title: "Subtotal", amount: subtotal)
                                
                                if deliveryOption == .delivery {
                                    PriceRow(title: "Delivery Fee", amount: deliveryFee)
                                }
                                
                                PriceRow(title: "Service Fee", amount: serviceFee)
                                
                                if isPromoApplied {
                                    PriceRow(title: "Discount", amount: -promoDiscount, isDiscount: true)
                                }
                                
                                Divider()
                                
                                HStack {
                                    Text("Total")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    Text("$\(String(format: "%.2f", total))")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.orange)
                                }
                            }
                            
                            Button(action: {
                                showingCheckout = true
                            }) {
                                HStack {
                                    Text("Complete Order")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    Text("$\(String(format: "%.2f", total))")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .background(Color.orange)
                                .cornerRadius(15)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: -5)
                    }
                }
            }
            .background(Color.gray.opacity(0.05))
            .navigationTitle("My Cart")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showingCheckout) {
                CheckoutView(total: total, deliveryOption: deliveryOption)
            }
            .sheet(isPresented: $showingAddressSelection) {
                AddressSelectionView(selectedAddress: $selectedAddress)
            }
            .sheet(isPresented: $showingPaymentMethods) {
                PaymentMethodView(selectedMethod: $paymentMethod)
            }
        }
    }

    
    private func updateQuantity(for id: Int, quantity: Int) {
        if let index = cartItems.firstIndex(where: { $0.id == id }) {
            if quantity > 0 {
                cartItems[index].quantity = quantity
            } else {
                cartItems.remove(at: index)
            }
        }
    }
    
    private func removeItem(id: Int) {
        cartItems.removeAll { $0.id == id }
    }
    
    private func applyPromoCode() {
        if promoCode.lowercased() == "coffee10" {
            isPromoApplied = true
        }
    }
}

struct CartItemCard: View {
    let item: CartItem
    let onQuantityChanged: (Int) -> Void
    let onRemove: () -> Void
    
    var body: some View {
        HStack(spacing: 15) {
          
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.brown.opacity(0.1))
                    .frame(width: 70, height: 70)
                
                Image(systemName: item.image)
                    .font(.title2)
                    .foregroundColor(.brown)
            }
            
         
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.name)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text("Boyut: \(item.size)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        if !item.extras.isEmpty {
                            Text("Ekstra: \(item.extras.joined(separator: ", "))")
                                .font(.caption)
                                .foregroundColor(.orange)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: onRemove) {
                        Image(systemName: "trash")
                            .font(.subheadline)
                            .foregroundColor(.red)
                    }
                }
                
                HStack {
                    Text("₺\(String(format: "%.2f", item.price))")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.orange)
                    
                    Spacer()
                    
                    HStack(spacing: 12) {
                        Button(action: {
                            if item.quantity > 1 {
                                onQuantityChanged(item.quantity - 1)
                            }
                        }) {
                            Image(systemName: "minus")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.orange)
                                .frame(width: 30, height: 30)
                                .background(Color.orange.opacity(0.1))
                                .cornerRadius(8)
                        }
                        
                        Text("\(item.quantity)")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .frame(minWidth: 30)
                        
                        Button(action: {
                            onQuantityChanged(item.quantity + 1)
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                                .background(Color.orange)
                                .cornerRadius(8)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct DeliveryOptionRow: View {
    let option: DeliveryOption
    @Binding var selectedOption: DeliveryOption
    let title: String
    let subtitle: String
    let icon: String
    
    var body: some View {
        Button(action: {
            selectedOption = option
        }) {
            HStack(spacing: 15) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.orange)
                    .frame(width: 30)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: selectedOption == option ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundColor(selectedOption == option ? .orange : .gray)
            }
            .padding()
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct PriceRow: View {
    let title: String
    let amount: Double
    let isDiscount: Bool
    
    init(title: String, amount: Double, isDiscount: Bool = false) {
        self.title = title
        self.amount = amount
        self.isDiscount = isDiscount
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.body)
                .foregroundColor(.primary)
            
            Spacer()
            
            Text("\(amount >= 0 ? "₺" : "-₺")\(String(format: "%.2f", abs(amount)))")
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(isDiscount ? .green : .primary)
        }
    }
}


struct EmptyCartView: View {
   var body: some View {
       VStack(spacing: 30) {
           Image(systemName: "cart")
               .font(.system(size: 80))
               .foregroundColor(.gray.opacity(0.5))
           
           VStack(spacing: 10) {
               Text("Your Cart is Empty")
                   .font(.title2)
                   .fontWeight(.bold)
                   .foregroundColor(.primary)
               
               Text("Browse our menu to discover delicious coffees!")
                   .font(.body)
                   .foregroundColor(.secondary)
                   .multilineTextAlignment(.center)
                   .padding(.horizontal)
           }
           
           Button(action: {
               
           }) {
               Text("Explore Menu")
                   .font(.headline)
                   .fontWeight(.semibold)
                   .foregroundColor(.white)
                   .padding()
                   .frame(maxWidth: .infinity)
                   .background(Color.orange)
                   .cornerRadius(15)
           }
           .padding(.horizontal, 50)
       }
       .frame(maxWidth: .infinity, maxHeight: .infinity)
   }
}


struct CartItem: Identifiable {
    let id: Int
    let name: String
    let description: String
    let price: Double
    var quantity: Int
    let image: String
    let size: String
    let extras: [String]
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.orange)
            
            Text(value)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct SectionHeader: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            Spacer()
        }
        .padding(.bottom, 10)
    }
}


#Preview("Cart with Items") {
    CartView()
}
