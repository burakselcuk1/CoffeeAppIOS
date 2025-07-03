//
//  ProfileView.swift
//  coffeeApp
//
//  Created by Burak Selçuk on 22.06.2025.
//
import SwiftUI

struct ProfileView: View {
    @State private var user = UserProfile(
        name: "Burak Selcuk",
        email: "burak.selcuk@burak.com",
        phoneNumber: "+1 555 123 45 67",
        membershipLevel: "Gold Member",
        totalOrders: 47,
        favoriteStore: "Downtown Branch",
        joinDate: "March 2023"
    )
    
    @State private var showingEditProfile = false
    @State private var notificationsEnabled = false
    @State private var locationEnabled = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    VStack(spacing: 15) {
                        ZStack {
                            Circle()
                                .fill(LinearGradient(
                                    gradient: Gradient(colors: [.orange, .red]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                                .frame(width: 100, height: 100)
                            
                            Text(user.initials)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        
                        VStack(spacing: 5) {
                            Text(user.name)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            Text(user.membershipLevel)
                                .font(.subheadline)
                                .foregroundColor(.orange)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color.orange.opacity(0.1))
                                .cornerRadius(15)
                        }
                    }
                    .padding(.top, 20)
                    
                    HStack(spacing: 20) {
                        StatCard(title: "Total Orders", value: "\(user.totalOrders)", icon: "bag.fill")
                        StatCard(title: "Favorite Store", value: user.favoriteStore, icon: "location.fill")
                        StatCard(title: "Member Since", value: user.joinDate, icon: "calendar.circle.fill")
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 0) {
                        SectionHeader(title: "Personal Information")
                        
                        VStack(spacing: 0) {
                            ProfileInfoRow(icon: "envelope.fill", title: "Email", value: user.email)
                            Divider().padding(.leading, 50)
                            ProfileInfoRow(icon: "phone.fill", title: "Phone", value: user.phoneNumber)
                        }
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 0) {
                        SectionHeader(title: "Settings")
                        
                        VStack(spacing: 0) {
                            SettingsToggleRow(
                                icon: "bell.fill",
                                title: "Notifications",
                                subtitle: "Order updates and special offers",
                                isOn: $notificationsEnabled
                            )
                            
                            Divider().padding(.leading, 50)
                            
                            SettingsToggleRow(
                                icon: "location.fill",
                                title: "Location Services",
                                subtitle: "Find nearby stores",
                                isOn: $locationEnabled
                            )
                        }
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 0) {
                        SectionHeader(title: "Other")
                        
                        VStack(spacing: 0) {
                            MenuRow(icon: "heart.fill", title: "My Favorites", color: .red)
                            Divider().padding(.leading, 50)
                            MenuRow(icon: "clock.fill", title: "Order History", color: .blue)
                            Divider().padding(.leading, 50)
                            MenuRow(icon: "creditcard.fill", title: "Payment Methods", color: .green)
                            Divider().padding(.leading, 50)
                            MenuRow(icon: "questionmark.circle.fill", title: "Help & Support", color: .purple)
                        }
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        // Logout action
                    }) {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .foregroundColor(.red)
                            Text("Sign Out")
                                .fontWeight(.semibold)
                                .foregroundColor(.red)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(15)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
            }
            .background(Color.gray.opacity(0.05))
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Edit") {
                        showingEditProfile = true
                    }
                    .foregroundColor(.orange)
                }
            }
        }
        .sheet(isPresented: $showingEditProfile) {
            EditProfileView(user: $user)
        }
    }
}


struct SettingsToggleRow: View {
    let icon: String
    let title: String
    let subtitle: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.orange)
                .frame(width: 20)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.body)
                    .foregroundColor(.primary)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: .orange))
        }
        .padding()
    }
}

struct MenuRow: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        Button(action: {
            
        }) {
            HStack(spacing: 15) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(color)
                    .frame(width: 20)
                
                Text(title)
                    .font(.body)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct EditProfileView: View {
   @Binding var user: UserProfile
   @Environment(\.presentationMode) var presentationMode
   
   @State private var editedName: String = ""
   @State private var editedEmail: String = ""
   @State private var editedPhone: String = ""
   
   var body: some View {
       NavigationView {
           Form {
               Section(header: Text("Personal Information")) {
                   TextField("Full Name", text: $editedName)
                   TextField("Email", text: $editedEmail)
                       .keyboardType(.emailAddress)
                   TextField("Phone", text: $editedPhone)
                       .keyboardType(.phonePad)
               }
           }
           .navigationTitle("Edit Profile")
           .navigationBarTitleDisplayMode(.inline)
           .toolbar {
               ToolbarItem(placement: .navigationBarLeading) {
                   Button("Cancel") {
                       presentationMode.wrappedValue.dismiss()
                   }
               }
               
               ToolbarItem(placement: .navigationBarTrailing) {
                   Button("Save") {
                       user.name = editedName
                       user.email = editedEmail
                       user.phoneNumber = editedPhone
                       presentationMode.wrappedValue.dismiss()
                   }
                   .foregroundColor(.orange)
               }
           }
       }
       .onAppear {
           editedName = user.name
           editedEmail = user.email
           editedPhone = user.phoneNumber
       }
   }
}
struct UserProfile {
    var name: String
    var email: String
    var phoneNumber: String
    let membershipLevel: String
    let totalOrders: Int
    let favoriteStore: String
    let joinDate: String
    
    var initials: String {
        let components = name.components(separatedBy: " ")
        let firstInitial = components.first?.first?.uppercased() ?? ""
        let lastInitial = components.count > 1 ? components.last?.first?.uppercased() ?? "" : ""
        return firstInitial + lastInitial
    }
}

struct ProfileInfoRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.orange)
                .frame(width: 20)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.body)
                    .foregroundColor(.primary)
            }
            
            Spacer()
        }
        .padding()
    }
}


#Preview("Default Profile") {
    ProfileView()
}
