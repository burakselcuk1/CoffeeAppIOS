import SwiftUI

struct ContentView: View {
    @State private var currentPage = 0
    @State private var isAuthenticated = false
    
    var body: some View {
        if isAuthenticated {
            MainTabView()
        } else {
            OnboardingView(isAuthenticated: $isAuthenticated)
        }
    }
}



struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "cup.and.saucer.fill" : "cup.and.saucer")
                    Text("Menu")
                }
                .tag(0)
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(1)
            
            MenuView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Menu")
                }
                .tag(2)
            
            CartView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Cart")
                }
                .tag(3)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .tag(4)
        }
        .accentColor(.orange)
    }
}


struct CoffeeCard: View {
    let coffee: CoffeeItem
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.brown.opacity(0.1))
                    .frame(height: 120)
                
                Image(systemName: coffee.imageName)
                    .font(.system(size: 40))
                    .foregroundColor(.brown)
            }
            
            VStack(spacing: 5) {
                Text(coffee.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                
                Text(coffee.price)
                    .font(.subheadline)
                    .foregroundColor(.orange)
                    .fontWeight(.semibold)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

struct CoffeeItem {
    let name: String
    let imageName: String
    let price: String
}

struct SearchView: View {
    var body: some View {
        Text("Search View")
            .font(.title)
    }
}

struct MenuView: View {
    @State private var selectedCategory = 0
    @State private var searchText = ""
    @State private var showingFilters = false
    @State private var sortOption = SortOption.popular
    
    let categories = ["Tümü", "Kahve", "Soğuk İçecek", "Tatlı", "Atıştırmalık"]
    
    let menuItems: [MenuItem] = [
        // Kahveler
        MenuItem(id: 1, name: "Americano", category: "Kahve", price: 25.00, image: "cup.and.saucer.fill", description: "Sade espresso ve sıcak su", isPopular: true, rating: 4.5, prepTime: "3-5 dk"),
        MenuItem(id: 2, name: "Cappuccino", category: "Kahve", price: 32.00, image: "cup.and.saucer.fill", description: "Espresso, buharlanmış süt ve süt köpüğü", isPopular: true, rating: 4.8, prepTime: "4-6 dk"),
        MenuItem(id: 3, name: "Latte", category: "Kahve", price: 35.00, image: "cup.and.saucer.fill", description: "Espresso ve bol buharlanmış süt", isPopular: false, rating: 4.6, prepTime: "4-6 dk"),
        MenuItem(id: 4, name: "Mocha", category: "Kahve", price: 38.00, image: "cup.and.saucer.fill", description: "Espresso, çikolata ve buharlanmış süt", isPopular: true, rating: 4.7, prepTime: "5-7 dk"),
        MenuItem(id: 5, name: "Macchiato", category: "Kahve", price: 30.00, image: "cup.and.saucer.fill", description: "Espresso üzerine bir kaşık süt köpüğü", isPopular: false, rating: 4.3, prepTime: "3-4 dk"),
        
        // Soğuk İçecekler
        MenuItem(id: 6, name: "Iced Americano", category: "Soğuk İçecek", price: 27.00, image: "cup.and.saucer", description: "Buzlu americano", isPopular: true, rating: 4.4, prepTime: "2-3 dk"),
        MenuItem(id: 7, name: "Cold Brew", category: "Soğuk İçecek", price: 30.00, image: "cup.and.saucer", description: "12 saat demlenmiş soğuk kahve", isPopular: true, rating: 4.6, prepTime: "1-2 dk"),
        MenuItem(id: 8, name: "Frappuccino", category: "Soğuk İçecek", price: 42.00, image: "cup.and.saucer", description: "Buzlu kahve karışımı ve krema", isPopular: false, rating: 4.2, prepTime: "3-5 dk"),
        
        // Tatlılar
        MenuItem(id: 9, name: "Tiramisu", category: "Tatlı", price: 45.00, image: "birthday.cake.fill", description: "Geleneksel İtalyan tatlısı", isPopular: true, rating: 4.9, prepTime: "Hazır"),
        MenuItem(id: 10, name: "Cheesecake", category: "Tatlı", price: 40.00, image: "birthday.cake.fill", description: "Kremsi cheesecake dilimi", isPopular: false, rating: 4.5, prepTime: "Hazır"),
        MenuItem(id: 11, name: "Brownie", category: "Tatlı", price: 35.00, image: "birthday.cake.fill", description: "Sıcak çikolatalı brownie", isPopular: true, rating: 4.7, prepTime: "2-3 dk"),
        
        // Atıştırmalıklar
        MenuItem(id: 12, name: "Croissant", category: "Atıştırmalık", price: 20.00, image: "fork.knife", description: "Tereyağlı croissant", isPopular: false, rating: 4.3, prepTime: "1-2 dk"),
        MenuItem(id: 13, name: "Muffin", category: "Atıştırmalık", price: 18.00, image: "fork.knife", description: "Çikolata parçacıklı muffin", isPopular: true, rating: 4.4, prepTime: "Hazır"),
        MenuItem(id: 14, name: "Sandviç", category: "Atıştırmalık", price: 28.00, image: "fork.knife", description: "Taze malzemeli sandviç", isPopular: false, rating: 4.1, prepTime: "3-5 dk")
    ]
    
    var filteredItems: [MenuItem] {
        var items = menuItems
        
        // Kategori filtresi
        if selectedCategory != 0 {
            let categoryName = categories[selectedCategory]
            items = items.filter { $0.category == categoryName }
        }
        
        // Arama filtresi
        if !searchText.isEmpty {
            items = items.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
        
        // Sıralama
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
                // Search Bar
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Menüde ara...", text: $searchText)
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
                
                // Category Filter
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
                
                // Menu Items
                ScrollView {
                    LazyVStack(spacing: 15) {
                        ForEach(filteredItems) { item in
                            MenuItemCard(item: item)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Menü")
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
            // Item Image
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
            
            // Item Info
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(item.name)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Text("₺\(String(format: "%.0f", item.price))")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                }
                
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                HStack {
                    // Rating
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.caption)
                            .foregroundColor(.orange)
                        Text(String(format: "%.1f", item.rating))
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    // Prep Time
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(item.prepTime)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    // Add to Cart Button
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

struct FilterView: View {
    @Binding var sortOption: SortOption
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Sıralama")
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
            .navigationTitle("Filtreler")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Tamam") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.orange)
                }
            }
        }
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
            return "Popülerlik"
        case .priceAsc:
            return "Fiyat (Düşükten Yükseğe)"
        case .priceDesc:
            return "Fiyat (Yüksekten Düşüğe)"
        case .rating:
            return "Değerlendirme"
        case .name:
            return "İsim (A-Z)"
        }
    }
}

struct CartView: View {
    var body: some View {
        Text("Cart View")
            .font(.title)
    }
}


struct ProfileView: View {
    @State private var user = UserProfile(
        name: "Ahmet Yılmaz",
        email: "ahmet.yilmaz@email.com",
        phoneNumber: "+90 555 123 45 67",
        membershipLevel: "Gold Member",
        totalOrders: 47,
        favoriteStore: "Kadıköy Şubesi",
        joinDate: "Mart 2023"
    )
    
    @State private var showingEditProfile = false
    @State private var notificationsEnabled = true
    @State private var locationEnabled = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    // Profile Header
                    VStack(spacing: 15) {
                        // Profile Image
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
                    
                    // Stats Section
                    HStack(spacing: 20) {
                        StatCard(title: "Toplam Sipariş", value: "\(user.totalOrders)", icon: "bag.fill")
                        StatCard(title: "Favori Mağaza", value: user.favoriteStore, icon: "location.fill")
                        StatCard(title: "Üyelik", value: user.joinDate, icon: "calendar.circle.fill")
                    }
                    .padding(.horizontal)
                    
                    // Personal Information
                    VStack(spacing: 0) {
                        SectionHeader(title: "Kişisel Bilgiler")
                        
                        VStack(spacing: 0) {
                            ProfileInfoRow(icon: "envelope.fill", title: "E-posta", value: user.email)
                            Divider().padding(.leading, 50)
                            ProfileInfoRow(icon: "phone.fill", title: "Telefon", value: user.phoneNumber)
                        }
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
                    }
                    .padding(.horizontal)
                    
                    // Settings Section
                    VStack(spacing: 0) {
                        SectionHeader(title: "Ayarlar")
                        
                        VStack(spacing: 0) {
                            SettingsToggleRow(
                                icon: "bell.fill",
                                title: "Bildirimler",
                                subtitle: "Sipariş güncellemeleri ve özel teklifler",
                                isOn: $notificationsEnabled
                            )
                            
                            Divider().padding(.leading, 50)
                            
                            SettingsToggleRow(
                                icon: "location.fill",
                                title: "Konum Servisleri",
                                subtitle: "Yakındaki mağazaları bul",
                                isOn: $locationEnabled
                            )
                        }
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
                    }
                    .padding(.horizontal)
                    
                    // Menu Options
                    VStack(spacing: 0) {
                        SectionHeader(title: "Diğer")
                        
                        VStack(spacing: 0) {
                            MenuRow(icon: "heart.fill", title: "Favorilerim", color: .red)
                            Divider().padding(.leading, 50)
                            MenuRow(icon: "clock.fill", title: "Sipariş Geçmişi", color: .blue)
                            Divider().padding(.leading, 50)
                            MenuRow(icon: "creditcard.fill", title: "Ödeme Yöntemleri", color: .green)
                            Divider().padding(.leading, 50)
                            MenuRow(icon: "questionmark.circle.fill", title: "Yardım & Destek", color: .purple)
                        }
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
                    }
                    .padding(.horizontal)
                    
                    // Logout Button
                    Button(action: {
                        // Logout action
                    }) {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .foregroundColor(.red)
                            Text("Çıkış Yap")
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
            .navigationTitle("Profil")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Düzenle") {
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
            // Menu item action
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
                Section(header: Text("Kişisel Bilgiler")) {
                    TextField("Ad Soyad", text: $editedName)
                    TextField("E-posta", text: $editedEmail)
                        .keyboardType(.emailAddress)
                    TextField("Telefon", text: $editedPhone)
                        .keyboardType(.phonePad)
                }
            }
            .navigationTitle("Profili Düzenle")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("İptal") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Kaydet") {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
