//
//  SettingsView.swift
//  TheMovies
//
//  Created by admin1 on 15.02.2022.
//

import SwiftUI

struct SettingsView: View {
    //MARK: - PROPERTIES
    
    @State private var selection = 1
    @State private var email = ""
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            Form {
                Picker(selection: $selection, label: Text("Favorite Genre")) {
                    Text("Action").tag(1)
                    Text("Comedy").tag(2)
                    Text("Horror").tag(3)
                    Text("Scify").tag(4)
                }
            }
        }
    }
}

//MARK: - PREVIEW
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
