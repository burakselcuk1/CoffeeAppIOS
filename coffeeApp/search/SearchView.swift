//
//  SearchView.swift
//  coffeeApp
//
//  Created by Burak Selçuk on 22.06.2025.
//
import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var selectedFilter = SearchFilter.all
    @State private var recentSearches: [String] = ["Cappuccino", "Latte", "Tiramisu", "Cold Brew", "Americano"]
    @State private var isSearching = false
    @State private var showingFilters = false
    
    let popularSearches = ["Coffee", "Cold Drink", "Dessert", "Americano", "Cappuccino", "Latte", "Mocha", "Tiramisu", "Brownie", "Sandwich"]
    
    let searchResults: [SearchResult] = [
       
        SearchResult(id: 1, title: "Americano", subtitle: "Simple espresso and hot water", type: .product, category: "Coffee", price: 25.00, image: "cup.and.saucer.fill", rating: 4.5, prepTime: "3-5 min"),
        SearchResult(id: 2, title: "Cappuccino", subtitle: "Espresso, steamed milk and milk foam", type: .product, category: "Coffee", price: 32.00, image: "cup.and.saucer.fill", rating: 4.8, prepTime: "4-6 min"),
        SearchResult(id: 3, title: "Latte", subtitle: "Espresso with plenty of steamed milk", type: .product, category: "Coffee", price: 35.00, image: "cup.and.saucer.fill", rating: 4.6, prepTime: "4-6 min"),
        SearchResult(id: 4, title: "Mocha", subtitle: "Espresso, chocolate and steamed milk", type: .product, category: "Coffee", price: 38.00, image: "cup.and.saucer.fill", rating: 4.7, prepTime: "5-7 min"),
        
        
        SearchResult(id: 5, title: "Cold Brew", subtitle: "12-hour steeped cold coffee", type: .product, category: "Cold Drink", price: 30.00, image: "cup.and.saucer", rating: 4.6, prepTime: "1-2 min"),
        SearchResult(id: 6, title: "Iced Americano", subtitle: "Iced americano", type: .product, category: "Cold Drink", price: 27.00, image: "cup.and.saucer", rating: 4.4, prepTime: "2-3 min"),
        
        
        SearchResult(id: 7, title: "Tiramisu", subtitle: "Traditional Italian dessert", type: .product, category: "Dessert", price: 45.00, image: "birthday.cake.fill", rating: 4.9, prepTime: "Ready"),
        SearchResult(id: 8, title: "Brownie", subtitle: "Warm chocolate brownie", type: .product, category: "Dessert", price: 35.00, image: "birthday.cake.fill", rating: 4.7, prepTime: "2-3 min"),
        
        
        SearchResult(id: 9, title: "Coffee", subtitle: "All coffee varieties", type: .category, category: "Category", price: 0, image: "cup.and.saucer.fill", rating: 0, prepTime: ""),
        SearchResult(id: 10, title: "Cold Drink", subtitle: "Refreshing beverages", type: .category, category: "Category", price: 0, image: "cup.and.saucer", rating: 0, prepTime: ""),
        SearchResult(id: 11, title: "Dessert", subtitle: "Delicious desserts", type: .category, category: "Category", price: 0, image: "birthday.cake.fill", rating: 0, prepTime: ""),
        
        
        SearchResult(id: 12, title: "Downtown Branch", subtitle: "123 Main Street, Downtown", type: .store, category: "Store", price: 0, image: "location.fill", rating: 4.5, prepTime: ""),
        SearchResult(id: 13, title: "Uptown Branch", subtitle: "456 Oak Avenue, Uptown", type: .store, category: "Store", price: 0, image: "location.fill", rating: 4.3, prepTime: ""),
        SearchResult(id: 14, title: "Central Branch", subtitle: "789 Broadway, Central", type: .store, category: "Store", price: 0, image: "location.fill", rating: 4.6, prepTime: "")
    ]
    
    var filteredResults: [SearchResult] {
        var results = searchResults
        
        if !searchText.isEmpty {
            results = results.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.subtitle.localizedCaseInsensitiveContains(searchText) ||
                $0.category.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        switch selectedFilter {
        case .all:
            break
        case .products:
            results = results.filter { $0.type == .product }
        case .categories:
            results = results.filter { $0.type == .category }
        case .stores:
            results = results.filter { $0.type == .store }
        }
        
        return results
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search products, categories or stores...", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                            .onSubmit {
                                performSearch()
                            }
                            .onChange(of: searchText) { _ in
                                isSearching = !searchText.isEmpty
                            }
                        
                        if !searchText.isEmpty {
                            Button(action: {
                                searchText = ""
                                isSearching = false
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                        }
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
                            .background(selectedFilter != .all ? Color.orange.opacity(0.2) : Color.orange.opacity(0.1))
                            .cornerRadius(12)
                    }
                }
                .padding()
                
                
                if selectedFilter != .all {
                    HStack {
                        FilterChip(title: selectedFilter.displayName, isActive: true) {
                            selectedFilter = .all
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                }
                
                ScrollView {
                    VStack(spacing: 20) {
                        if searchText.isEmpty {
                            
                            if !recentSearches.isEmpty {
                                VStack(alignment: .leading, spacing: 15) {
                                    HStack {
                                        Text("Recent Searches")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                        
                                        Spacer()
                                        
                                        Button("Clear") {
                                            recentSearches.removeAll()
                                        }
                                        .font(.subheadline)
                                        .foregroundColor(.orange)
                                    }
                                    
                                    LazyVStack(spacing: 0) {
                                        ForEach(recentSearches.prefix(5), id: \.self) { search in
                                            RecentSearchRow(searchText: search) {
                                                self.searchText = search
                                                isSearching = true
                                            } onDelete: {
                                                recentSearches.removeAll { $0 == search }
                                            }
                                            
                                            if search != recentSearches.prefix(5).last {
                                                Divider()
                                            }
                                        }
                                    }
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
                                }
                                .padding(.horizontal)
                            }
                            
                            
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Popular Searches")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .padding(.horizontal)
                                
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
                                    ForEach(popularSearches, id: \.self) { search in
                                        PopularSearchCard(title: search) {
                                            searchText = search
                                            isSearching = true
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        } else {
                           
                            VStack(alignment: .leading, spacing: 15) {
                                HStack {
                                    Text("Search Results")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    Text("\(filteredResults.count) results")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                .padding(.horizontal)
                                
                                if filteredResults.isEmpty {
                                    VStack(spacing: 20) {
                                        Image(systemName: "magnifyingglass")
                                            .font(.system(size: 50))
                                            .foregroundColor(.gray)
                                        
                                        Text("No results found")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.primary)
                                        
                                        Text("Try different keywords or change your filters.")
                                            .font(.body)
                                            .foregroundColor(.secondary)
                                            .multilineTextAlignment(.center)
                                            .padding(.horizontal)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.top, 50)
                                } else {
                                    LazyVStack(spacing: 15) {
                                        ForEach(filteredResults) { result in
                                            SearchResultCard(result: result)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showingFilters) {
                SearchFilterView(selectedFilter: $selectedFilter)
            }
        }
    }

    
    private func performSearch() {
        if !searchText.isEmpty && !recentSearches.contains(searchText) {
            recentSearches.insert(searchText, at: 0)
            if recentSearches.count > 10 {
                recentSearches.removeLast()
            }
        }
    }
}

struct FilterChip: View {
    let title: String
    let isActive: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(isActive ? .white : .orange)
                
                if isActive {
                    Image(systemName: "xmark")
                        .font(.caption)
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 8)
            .background(isActive ? Color.orange : Color.orange.opacity(0.1))
            .cornerRadius(20)
        }
    }
}

struct RecentSearchRow: View {
    let searchText: String
    let onTap: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack {
                Image(systemName: "clock.arrow.circlepath")
                    .font(.title3)
                    .foregroundColor(.gray)
                
                Text(searchText)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Button(action: onDelete) {
                    Image(systemName: "xmark")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct PopularSearchCard: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.subheadline)
                    .foregroundColor(.orange)
                
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: .gray.opacity(0.1), radius: 3, x: 0, y: 1)
        }
    }
}

struct SearchResultCard: View {
    let result: SearchResult
    
    var body: some View {
        HStack(spacing: 15) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(result.type.backgroundColor)
                    .frame(width: 60, height: 60)
                
                Image(systemName: result.image)
                    .font(.title2)
                    .foregroundColor(result.type.iconColor)
            }
            
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(result.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    if result.type == .product {
                        Text("₺\(String(format: "%.0f", result.price))")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                    }
                }
                
                Text(result.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                HStack {
                   
                    Text(result.type.displayName)
                        .font(.caption)
                        .foregroundColor(result.type.iconColor)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(result.type.backgroundColor)
                        .cornerRadius(8)
                    
                    if result.type == .product && result.rating > 0 {
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .font(.caption)
                                .foregroundColor(.orange)
                            Text(String(format: "%.1f", result.rating))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Spacer()
                    
                    if result.type == .product && !result.prepTime.isEmpty {
                        HStack(spacing: 4) {
                            Image(systemName: "clock")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(result.prepTime)
                                .font(.caption)
                                .foregroundColor(.secondary)
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

struct SearchFilterView: View {
   @Binding var selectedFilter: SearchFilter
   @Environment(\.presentationMode) var presentationMode
   
   var body: some View {
       NavigationView {
           VStack(alignment: .leading, spacing: 20) {
               Text("Search Filters")
                   .font(.headline)
                   .fontWeight(.bold)
                   .padding(.horizontal)
               
               VStack(spacing: 0) {
                   ForEach(SearchFilter.allCases, id: \.self) { filter in
                       Button(action: {
                           selectedFilter = filter
                       }) {
                           HStack {
                               VStack(alignment: .leading, spacing: 4) {
                                   Text(filter.displayName)
                                       .foregroundColor(.primary)
                                       .font(.body)
                                   
                                   Text(filter.description)
                                       .foregroundColor(.secondary)
                                       .font(.caption)
                               }
                               
                               Spacer()
                               
                               if selectedFilter == filter {
                                   Image(systemName: "checkmark")
                                       .foregroundColor(.orange)
                               }
                           }
                           .padding()
                       }
                       
                       if filter != SearchFilter.allCases.last {
                           Divider()
                       }
                   }
               }
               .background(Color.white)
               .cornerRadius(15)
               .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
               .padding(.horizontal)
               
               Spacer()
           }
           .background(Color.gray.opacity(0.05))
           .navigationTitle("Filters")
           .navigationBarTitleDisplayMode(.inline)
           .toolbar {
               ToolbarItem(placement: .navigationBarTrailing) {
                   Button("Done") {
                       presentationMode.wrappedValue.dismiss()
                   }
                   .foregroundColor(.orange)
               }
           }
       }
   }
}

struct SearchResult: Identifiable {
    let id: Int
    let title: String
    let subtitle: String
    let type: SearchResultType
    let category: String
    let price: Double
    let image: String
    let rating: Double
    let prepTime: String
}
enum SearchResultType: CaseIterable {
   case product
   case category
   case store
   
   var displayName: String {
       switch self {
       case .product: return "Product"
       case .category: return "Category"
       case .store: return "Store"
       }
   }
   
   var backgroundColor: Color {
       switch self {
       case .product: return Color.brown.opacity(0.1)
       case .category: return Color.orange.opacity(0.1)
       case .store: return Color.blue.opacity(0.1)
       }
   }
   
   var iconColor: Color {
       switch self {
       case .product: return .brown
       case .category: return .orange
       case .store: return .blue
       }
   }
}
enum SearchFilter: CaseIterable {
   case all
   case products
   case categories
   case stores
   
   var displayName: String {
       switch self {
       case .all: return "All"
       case .products: return "Products"
       case .categories: return "Categories"
       case .stores: return "Stores"
       }
   }
   
   var description: String {
       switch self {
       case .all: return "Show all results"
       case .products: return "Coffee, desserts and snacks"
       case .categories: return "Product categories"
       case .stores: return "Store locations"
       }
   }
}

struct FilterView: View {
    @Binding var sortOption: SortOption
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Sort By")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                VStack(spacing: 0) {
                    ForEach(SortOption.allCases, id: \.self) { option in
                        Button(action: {
                            sortOption = option
                        }) {
                            HStack {
                                Text(option.displayName)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                if sortOption == option {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.orange)
                                }
                            }
                            .padding()
                        }
                        
                        if option != SortOption.allCases.last {
                            Divider()
                        }
                    }
                }
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
                .padding(.horizontal)
                
                Spacer()
            }
            .background(Color.gray.opacity(0.05))
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.orange)
                }
            }
        }
    }
}

#Preview("Default Search") {
    SearchView()
}

