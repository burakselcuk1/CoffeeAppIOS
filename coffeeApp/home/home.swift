//
//  home.swift
//  coffeeApp
//
//  Created by Burak Selçuk on 8.06.2025.
//
import SwiftUI


struct HomeView: View {
    @State private var searchText = ""
    @State private var currentSlide = 0
    
    let coffeeTypes = [
        CoffeeItem(name: "Cappuccino", imageName: "cup.and.saucer.fill", price: "$4.50"),
        CoffeeItem(name: "Caffé Latte", imageName: "cup.and.saucer.fill", price: "$4.00"),
        CoffeeItem(name: "Caffé Mocha", imageName: "cup.and.saucer.fill", price: "$5.00"),
        CoffeeItem(name: "Caffé Americano", imageName: "cup.and.saucer.fill", price: "$3.50"),
        CoffeeItem(name: "Espresso Macchiato", imageName: "cup.and.saucer.fill", price: "$3.00"),
        CoffeeItem(name: "Ristretto", imageName: "cup.and.saucer.fill", price: "$3.25")
    ]
    
    let dessertSlides = [
        DessertSlide(
            title: "Discover Our Desserts",
            subtitle: "Sweet treats that perfectly complement your coffee",
            buttonText: "Try Now",
            backgroundImage: "coffee_background_2",
            icon: "birthday.cake.fill"
        ),
        DessertSlide(
            title: "Sweet Treats Available",
            subtitle: "Handcrafted desserts made with love",
            buttonText: "Order Now",
            backgroundImage: "coffee_background_2",
            icon: "heart.fill"
        ),
        DessertSlide(
            title: "Perfect Coffee Pairings",
            subtitle: "The ideal combination for your taste buds",
            buttonText: "Explore",
            backgroundImage: "coffee_background_2",
            icon: "star.fill"
        )
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(spacing: 15) {
                        HStack {
                            Text("Good Morning!")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Image(systemName: "line.3.horizontal")
                                    .font(.title2)
                                    .foregroundColor(.orange)
                                    .padding(10)
                                    .background(Color.orange.opacity(0.1))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("Search coffee", text: $searchText)
                                .textFieldStyle(PlainTextFieldStyle())
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 15)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(25)
                        .padding(.horizontal)
                    }
                    
                    TabView(selection: $currentSlide) {
                        ForEach(0..<dessertSlides.count, id: \.self) { index in
                            ZStack {
                                Image(dessertSlides[index].backgroundImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 180)
                                    .clipped()
                                    .cornerRadius(20)
                                
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.black.opacity(0.3),
                                        Color.black.opacity(0.6)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                                .cornerRadius(20)
                                
                                HStack {
                                    VStack(alignment: .leading, spacing: 12) {
                                        Text(dessertSlides[index].title)
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.white)
                                            .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 1)
                                        
                                        Text(dessertSlides[index].subtitle)
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(.white.opacity(0.9))
                                            .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 1)
                                            .lineLimit(2)
                                        
                                        Button(dessertSlides[index].buttonText) {
                                            
                                        }
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 10)
                                        .background(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color.orange, Color.orange.opacity(0.8)]),
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                        .cornerRadius(20)
                                        .shadow(color: .orange.opacity(0.4), radius: 5, x: 0, y: 2)
                                    }
                                    .padding(.leading, 5)
                                    
                                    Spacer()
                                    
                                    VStack {
                                        Image(systemName: dessertSlides[index].icon)
                                            .font(.system(size: 50))
                                            .foregroundColor(.white.opacity(0.9))
                                            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
                                        
                                        Spacer()
                                    }
                                    .padding(.top, 10)
                                    .padding(.trailing, 5)
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 15)
                            }
                            .frame(height: 180)
                            .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: 180)
                    .padding(.horizontal)
                    
                    HStack(spacing: 10) {
                        ForEach(0..<dessertSlides.count, id: \.self) { index in
                            Circle()
                                .fill(currentSlide == index ? Color.orange : Color.gray.opacity(0.3))
                                .frame(width: 8, height: 8)
                                .scaleEffect(currentSlide == index ? 1.2 : 1.0)
                                .animation(.easeInOut(duration: 0.3), value: currentSlide)
                        }
                    }
                    .padding(.bottom, 10)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Text("Popular Coffees")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            Button("See All") {
                                
                            }
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.orange)
                        }
                        .padding(.horizontal)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 15) {
                            ForEach(coffeeTypes, id: \.name) { coffee in
                                CoffeeCard(coffee: coffee)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 20)
            }
            .navigationBarHidden(true)
            .background(Color(.systemBackground))
        }
    }
}

struct DessertSlide {
    let title: String
    let subtitle: String
    let buttonText: String
    let backgroundImage: String
    let icon: String
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
