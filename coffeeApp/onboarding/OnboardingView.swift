//
//  OnboardingView.swift
//  coffeeApp
//
//  Created by Burak Selçuk on 20.06.2025.
//
import SwiftUI

struct OnboardingView: View {
    @Binding var isAuthenticated: Bool
    @State private var currentPage = 0
    @State private var showSignIn = false
    @State private var showSignUp = false
    
    let onboardingData = [
        OnboardingPage(
            title: "Coffee Break",
            subtitle: "ENJOY YOUR DAY\nWITH COFFEE",
            imageName: "cup.and.saucer.fill",
            backgroundImageName: "coffee_background_1"
        ),
        OnboardingPage(
            title: "Premium Quality",
            subtitle: "TASTE THE BEST\nCOFFEE EXPERIENCE",
            imageName: "leaf.fill",
            backgroundImageName: "coffee_background_2"
        ),
        OnboardingPage(
            title: "Fast Delivery",
            subtitle: "GET YOUR COFFEE\nIN MINUTES",
            imageName: "bicycle",
            backgroundImageName: "coffee_background_3"
        )
    ]
    
    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(0..<onboardingData.count, id: \.self) { index in
                ZStack {
                    
                    if let backgroundImageName = onboardingData[index].backgroundImageName {
                        Image(backgroundImageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(
                                width: UIScreen.main.bounds.width,
                                height: UIScreen.main.bounds.height
                            )
                            .clipped()
                            .ignoresSafeArea(.all)
                    }
                    
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.black.opacity(0.3),
                            Color.black.opacity(0.6),
                            Color.black.opacity(0.8)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea(.all)
                    
                    VStack {
                        Spacer()
                        Spacer()
                        
                        VStack(spacing: 30) {
                            Image(systemName: onboardingData[index].imageName)
                                .font(.system(size: 100))
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
                            
                            VStack(spacing: 15) {
                                Text(onboardingData[index].title)
                                    .font(.system(size: 32, weight: .bold, design: .default))
                                    .foregroundColor(.white)
                                    .shadow(color: .black.opacity(0.7), radius: 5, x: 0, y: 2)
                                
                                Text(onboardingData[index].subtitle)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white.opacity(0.9))
                                    .multilineTextAlignment(.center)
                                    .shadow(color: .black.opacity(0.7), radius: 3, x: 0, y: 1)
                            }
                        }
                        
                        Spacer()
                        
                        VStack(spacing: 30) {
                            HStack(spacing: 12) {
                                ForEach(0..<onboardingData.count, id: \.self) { dotIndex in
                                    Circle()
                                        .fill(currentPage == dotIndex ? Color.orange : Color.white.opacity(0.4))
                                        .frame(width: 10, height: 10)
                                        .scaleEffect(currentPage == dotIndex ? 1.2 : 1.0)
                                        .animation(.easeInOut(duration: 0.3), value: currentPage)
                                }
                            }
                            
                            Button(action: {
                                if currentPage < onboardingData.count - 1 {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        currentPage += 1
                                    }
                                } else {
                                    showSignIn = true
                                }
                            }) {
                                Text(currentPage < onboardingData.count - 1 ? "Next" : "Get Started")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.orange, Color.orange.opacity(0.8)]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .cornerRadius(30)
                                    .shadow(color: .orange.opacity(0.4), radius: 10, x: 0, y: 5)
                            }
                            .padding(.horizontal, 50)
                        }
                        .padding(.bottom, 50)
                    }
                }
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .ignoresSafeArea(.all)
        .sheet(isPresented: $showSignIn) {
            SignInView(isAuthenticated: $isAuthenticated, showSignUp: $showSignUp)
        }
        .sheet(isPresented: $showSignUp) {
            SignUpView(isAuthenticated: $isAuthenticated, showSignIn: $showSignIn)
        }
    }
}

struct OnboardingPage {
    let title: String
    let subtitle: String
    let imageName: String
    let backgroundImageName: String?
}

#Preview {
    OnboardingView(isAuthenticated: .constant(false))
}

#Preview("Second Page") {
    struct PreviewWrapper: View {
        @State private var isAuthenticated = false
        @State private var currentPage = 1
        
        var body: some View {
            OnboardingView(isAuthenticated: $isAuthenticated)
        }
    }
    
    return PreviewWrapper()
}
