//
//  MenuView.swift
//  coffeeApp
//
//  Created by Burak Selçuk on 22.06.2025.
//
import SwiftUI

struct MenuView: View {
    @State private var selectedCategory = 0
    @State private var searchText = ""
    @State private var showingFilters = false
    @State private var sortOption = SortOption.popular
    
    let categories = ["All", "Coffee", "Cold Drink", "Dessert", "Snacks"]
    
    let menuItems: [MenuItem] = [
        
        MenuItem(id: 1, name: "Americano", category: "Coffee", price: 25.00, image: "cup.and.saucer.fill", description: "Simple espresso and hot water", isPopular: true, rating: 4.5, prepTime: "3-5 min"),
        MenuItem(id: 2, name: "Cappuccino", category: "Coffee", price: 32.00, image: "cup.and.saucer.fill", description: "Espresso, steamed milk and milk foam", isPopular: true, rating: 4.8, prepTime: "4-6 min"),
        MenuItem(id: 3, name: "Latte", category: "Coffee", price: 35.00, image: "cup.and.saucer.fill", description: "Espresso with plenty of steamed milk", isPopular: false, rating: 4.6, prepTime: "4-6 min"),
        MenuItem(id: 4, name: "Mocha", category: "Coffee", price: 38.00, image: "cup.and.saucer.fill", description: "Espresso, chocolate and steamed milk", isPopular: true, rating: 4.7, prepTime: "5-7 min"),
        MenuItem(id: 5, name: "Macchiato", category: "Coffee", price: 30.00, image: "cup.and.saucer.fill", description: "Espresso topped with a dollop of milk foam", isPopular: false, rating: 4.3, prepTime: "3-4 min"),
        
        
        MenuItem(id: 6, name: "Iced Americano", category: "Cold Drink", price: 27.00, image: "cup.and.saucer", description: "Iced americano", isPopular: true, rating: 4.4, prepTime: "2-3 min"),
        MenuItem(id: 7, name: "Cold Brew", category: "Cold Drink", price: 30.00, image: "cup.and.saucer", description: "12-hour steeped cold coffee", isPopular: true, rating: 4.6, prepTime: "1-2 min"),
        MenuItem(id: 8, name: "Frappuccino", category: "Cold Drink", price: 42.00, image: "cup.and.saucer", description: "Iced coffee blend with whipped cream", isPopular: false, rating: 4.2, prepTime: "3-5 min"),
        
       
        MenuItem(id: 9, name: "Tiramisu", category: "Dessert", price: 45.00, image: "birthday.cake.fill", description: "Traditional Italian dessert", isPopular: true, rating: 4.9, prepTime: "Ready"),
        MenuItem(id: 10, name: "Cheesecake", category: "Dessert", price: 40.00, image: "birthday.cake.fill", description: "Creamy cheesecake slice", isPopular: false, rating: 4.5, prepTime: "Ready"),
        MenuItem(id: 11, name: "Brownie", category: "Dessert", price: 35.00, image: "birthday.cake.fill", description: "Warm chocolate brownie", isPopular: true, rating: 4.7, prepTime: "2-3 min"),
        
       
        MenuItem(id: 12, name: "Croissant", category: "Snacks", price: 20.00, image: "fork.knife", description: "Buttery croissant", isPopular: false, rating: 4.3, prepTime: "1-2 min"),
        MenuItem(id: 13, name: "Muffin", category: "Snacks", price: 18.00, image: "fork.knife", description: "Chocolate chip muffin", isPopular: true, rating: 4.4, prepTime: "Ready"),
        MenuItem(id: 14, name: "Sandwich", category: "Snacks", price: 28.00, image: "fork.knife", description: "Fresh ingredient sandwich", isPopular: false, rating: 4.1, prepTime: "3-5 min")
    ]
    
    var filteredItems: [MenuItem] {
        var items = menuItems
        
        
        if selectedCategory != 0 {
            let categoryName = categories[selectedCategory]
            items = items.filter { $0.category == categoryName }
        }
        
       
        if !searchText.isEmpty {
            items = items.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
        
       
        switch sortOption {
        case .popular:
            items = items.sorted { $0.isPopular && !$1.isPopular }
        case .priceAsc:
            items = items.sorted { $0.price < $1.price }
        case .priceDesc:
            items = items.sorted { $0.price > $1.price }
        case .rating:
            items = items.sorted { $0.rating > $1.rating }
        case .name:
            items = items.sorted { $0.name < $1.name }
        }
        
        return items
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search menu...", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    
                    Button(action: {
                        showingFilters = true
                    }) {
                        Image(systemName: "slider.horizontal.3")
                            .font(.title2)
                            .foregroundColor(.orange)
                            .padding(12)
                            .background(Color.orange.opacity(0.1))
                            .cornerRadius(12)
                    }
                }
                .padding()
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(0..<categories.count, id: \.self) { index in
                            CategoryButton(
                                title: categories[index],
                                isSelected: selectedCategory == index
                            ) {
                                selectedCategory = index
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 10)
                
              
                ScrollView {
                    LazyVStack(spacing: 15) {
                        ForEach(filteredItems) { item in
                            MenuItemCard(item: item)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Menu")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showingFilters) {
                FilterView(sortOption: $sortOption)
            }
        }
    }
}

struct CategoryButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(isSelected ? Color.orange : Color.gray.opacity(0.1))
                .cornerRadius(20)
        }
    }
}

struct MenuItemCard: View {
    let item: MenuItem
    @State private var quantity = 0
    
    var body: some View {
        HStack(spacing: 15) {
           
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.brown.opacity(0.1))
                    .frame(width: 80, height: 80)
                
                Image(systemName: item.image)
                    .font(.system(size: 30))
                    .foregroundColor(.brown)
                
                if item.isPopular {
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "star.fill")
                                .font(.caption)
                                .foregroundColor(.orange)
                                .padding(4)
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        Spacer()
                    }
                }
            }
            
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(item.name)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Text("$\(String(format: "%.0f", item.price))")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                }
                
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                HStack {
                   
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.caption)
                            .foregroundColor(.orange)
                        Text(String(format: "%.1f", item.rating))
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(item.prepTime)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                   
                    if quantity == 0 {
                        Button(action: {
                            quantity = 1
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                                .background(Color.orange)
                                .cornerRadius(8)
                        }
                    } else {
                        HStack(spacing: 8) {
                            Button(action: {
                                if quantity > 0 {
                                    quantity -= 1
                                }
                            }) {
                                Image(systemName: "minus")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.orange)
                                    .frame(width: 25, height: 25)
                                    .background(Color.orange.opacity(0.1))
                                    .cornerRadius(6)
                            }
                            
                            Text("\(quantity)")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .frame(minWidth: 20)
                            
                            Button(action: {
                                quantity += 1
                            }) {
                                Image(systemName: "plus")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(width: 25, height: 25)
                                    .background(Color.orange)
                                    .cornerRadius(6)
                            }
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


struct MenuItem: Identifiable {
    let id: Int
    let name: String
    let category: String
    let price: Double
    let image: String
    let description: String
    let isPopular: Bool
    let rating: Double
    let prepTime: String
}

enum SortOption: CaseIterable {
    case popular
    case priceAsc
    case priceDesc
    case rating
    case name
    
    var displayName: String {
        switch self {
        case .popular:
            return "Popularity"
        case .priceAsc:
            return "Price (Low to High)"
        case .priceDesc:
            return "Price (High to Low)"
        case .rating:
            return "Rating"
        case .name:
            return "Name (A-Z)"
        }
    }
}

#Preview("Full Menu") {
    MenuView()
}
