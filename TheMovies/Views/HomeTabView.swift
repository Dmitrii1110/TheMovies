//
//  HomeTabView.swift
//  TheMovies
//
//  Created by admin1 on 15.02.2022.
//

import SwiftUI

struct HomeTabView: View {
    //MARK: - PROPERTIES
    
    enum Tab: Int {
        case movie
        case discover
    }
    
    @State private var selectedTab = Tab.movie
    
    //MARK: - BODY
    var body: some View {
        TabView(selection: $selectedTab) {
            MoviesView().tabItem {
                tabBarItem(text: "Movies", image: "film")
            }.tag("Tab.movie")
            
            DiscoverView().tabItem {
                tabBarItem(text: "Discover", image: "square.stack")
            }.tag(Tab.discover)
        }
    }
    
    private func tabBarItem(text: String, image: String) -> some View {
        VStack {
            Image(systemName: image).imageScale(.large)
            
            Text(text)
        }
    }
}

//MARK: - PREVIEW
struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
