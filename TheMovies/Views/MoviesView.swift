//
//  MoviesView.swift
//  TheMovies
//
//  Created by admin1 on 15.02.2022.
//

import SwiftUI

struct MoviesView: View {
    //MARK: - PROPERTIES
    
    @State private var searchTerm = ""
    @State private var selectionIndex = 0
    @State private var tabs = ["Now Playing", "Upcoming", "Trending"]
    
    @ObservedObject var movieManager = MovieDownloadManager()
    
    init() {
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableViewCell.appearance().selectionStyle = .none
        
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = .orange
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.orange]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.orange]
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    
    //MARK: - BODY
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(tabs[selectionIndex])
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.red)
                    .padding(.top)
                
                HStack {
                    Image(systemName: "magnifyingglass").imageScale(.medium)
                    
                    TextField("Search...", text: $searchTerm)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }//HSTACK
            }.padding(.horizontal)//VSTACK
            
            //segment control
            VStack {
                Picker("_", selection: $selectionIndex) {
                    ForEach(0..<tabs.count) { index in
                        Text(tabs[index])
                            .font(.title)
                            .bold()
                            .tag(index)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                    .onChange(of: selectionIndex) { (_) in
                        if selectionIndex == 0 {
                            movieManager.getNowPlaying()
                        } else if selectionIndex == 1 {
                            movieManager.getUpcoming()
                        } else if selectionIndex == 2 {
                            movieManager.getPopular()
                        }
                    }
            }.padding()//VSTACK
            
            List {
                ForEach(movieManager.movies.filter {
                    searchTerm.isEmpty ? true : $0.title?.lowercased().localizedStandardContains(searchTerm.lowercased()) ?? true }) { movie in
                        NavigationLink(destination: Text(movie.titleWithLanguage)) {
                            Text(movie.titleWithLanguage)
                        }.listRowBackground(Color.clear)
                }
            }.onAppear {
                movieManager.getNowPlaying()
            }
            
            Spacer()
            
        }//VSTACK
    }
}

//MARK: - PREVIEW
struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
