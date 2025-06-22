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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
