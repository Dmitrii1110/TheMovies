//
//  ContentView.swift
//  TheMovies
//
//  Created by admin1 on 15.02.2022.
//

import SwiftUI

struct ContentView: View {
    //MARK: - PROPERTIES
    
    @State private var showSettings = false
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            Group {
                HomeTabView()
            }.navigationBarTitle("Movies", displayMode: .automatic)
                .navigationBarItems(trailing: HStack {
                    settingsButton
                })
                .sheet(isPresented: $showSettings, content: { Text("SettingsView")
                })
        }
    }
    
    private var settingsButton: some View {
        Button(action: {
            showSettings.toggle()
        }, label: {
            HStack {
                Image (systemName: "gear")
                    .imageScale(.large)
                    .foregroundColor(.gray)
            }.frame(width: 30, height: 30)
        })
    }
}

//MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
