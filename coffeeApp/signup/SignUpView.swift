//
//  SignUpView.swift
//  coffeeApp
//
//  Created by Burak Selçuk on 8.06.2025.
//
import SwiftUI

struct SignUpView: View {
    @Binding var isAuthenticated: Bool
    @Binding var showSignIn: Bool
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
           
            Image("coffee_background_1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height
                )
                .clipped()
                .ignoresSafeArea(.all)
            
            
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black.opacity(0.4),
                    Color.black.opacity(0.7),
                    Color.black.opacity(0.9)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 30) {
                    Spacer()
                        .frame(height: 80)
                    
                    VStack(spacing: 15) {
                        Text("SIGN UP")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 2)
                        
                        VStack(spacing: 5) {
                            Text("Create A New Account")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white.opacity(0.9))
                            
                            Text("And Experience The Joy Of Life!")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white.opacity(0.9))
                        }
                        .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 1)
                    }
                    
                    VStack(spacing: 25) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Email Address")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .medium))
                                .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                            
                            HStack {
                                Image(systemName: "envelope")
                                    .foregroundColor(.gray)
                                    .frame(width: 20)
                                TextField("Enter your email", text: $email)
                                    .foregroundColor(.black)
                                    .font(.system(size: 16))
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                            .background(Color.white.opacity(0.95))
                            .cornerRadius(25)
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Password")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .medium))
                                .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                            
                            HStack {
                                Image(systemName: "lock")
                                    .foregroundColor(.gray)
                                    .frame(width: 20)
                                SecureField("Enter your password", text: $password)
                                    .foregroundColor(.black)
                                    .font(.system(size: 16))
                                Button(action: {}) {
                                    Image(systemName: "eye.slash")
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                            .background(Color.white.opacity(0.95))
                            .cornerRadius(25)
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Confirm Password")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .medium))
                                .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                            
                            HStack {
                                Image(systemName: "lock")
                                    .foregroundColor(.gray)
                                    .frame(width: 20)
                                SecureField("Confirm your password", text: $confirmPassword)
                                    .foregroundColor(.black)
                                    .font(.system(size: 16))
                                Button(action: {}) {
                                    Image(systemName: "eye.slash")
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                            .background(Color.white.opacity(0.95))
                            .cornerRadius(25)
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                        }
                    }
                    .padding(.horizontal, 40)
                    
                    Button(action: {
                        isAuthenticated = true
                        dismiss()
                    }) {
                        Text("SIGN UP")
                            .font(.system(size: 18, weight: .bold))
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
                            .cornerRadius(25)
                            .shadow(color: .orange.opacity(0.4), radius: 8, x: 0, y: 4)
                    }
                    .padding(.horizontal, 40)
                    
                    Text("Or Sign Up With")
                        .foregroundColor(.white.opacity(0.7))
                        .font(.system(size: 14))
                        .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                    
                    HStack(spacing: 25) {
                        socialButton(icon: "f.circle.fill")
                        socialButton(icon: "g.circle.fill")
                        socialButton(icon: "applelogo")
                    }
                    
                    HStack {
                        Text("Already have an account?")
                            .foregroundColor(.white.opacity(0.8))
                            .font(.system(size: 16))
                        Button("Sign In") {
                            dismiss()
                            showSignIn = true
                        }
                        .foregroundColor(.orange)
                        .font(.system(size: 16, weight: .semibold))
                    }
                    .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                    .padding(.bottom, 40)
                }
            }
        }
    }
    
    private func socialButton(icon: String) -> some View {
        Button(action: {}) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.white)
                .frame(width: 55, height: 55)
                .background(Color.white.opacity(0.15))
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(
            isAuthenticated: .constant(false),
            showSignIn: .constant(false)
        )
    }
}
