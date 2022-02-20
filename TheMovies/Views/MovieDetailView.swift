//
//  MovieDetailView.swift
//  TheMovies
//
//  Created by admin1 on 18.02.2022.
//

import SwiftUI

struct MovieDetailView: View {
    //MARK: - PROPERTIES
    
    @StateObject private var loader: ImageLoader
    @ObservedObject private var movieManager = MovieDownloadManager()
    
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        _loader = StateObject(wrappedValue: ImageLoader(url: URL(string: movie.posterPath)!, cache: Environment(\.imageCache).wrappedValue))
    }
    
    //MARK: - BODY
    var body: some View {
        ZStack(alignment: .top) {
            backgroundView
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    headerView
                    moviePosterView
                    movieOverview
                    reviewLink
                    castInfo
                    Spacer()
                    
                }.padding(.top, 84)//VSTACK
                    .padding(.horizontal, 32)
            }
        }.edgesIgnoringSafeArea(.all)//ZSTACK
    }
    
    private var backgroundView: some View {
        imageView.onAppear() {
        loader.load()
    }
    .blur(radius: 100)
    }

    private var imageView: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
            } else {
                Rectangle().foregroundColor(Color.gray.opacity(0.4))
            }
        }
    }
    
    private var headerView: some View {
        VStack {
            Text(movie.titleWithLanguage)
                .font(.title)
            
            Text("Release Date: \(movie.release_date ?? "_")")
                .font(.subheadline)
        }.foregroundColor(.white)
    }
    
    private var moviePosterView: some View {
        HStack(alignment: .center) {
            Spacer()
            imageView.frame(width: 200, height: 320)
                .cornerRadius(20)
            Spacer()
        }//HSTACK
    }
    
    private var movieOverview: some View {
        Text(movie.overview ?? "_")
            .font(.body)
            .foregroundColor(.white)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.top, 16)
    }
    
    private var reviewLink: some View {
        VStack {
            Divider()
            NavigationLink(destination: MovieReviewView(movie: movie)) {
                HStack {
                    Text("Reviews")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    Spacer()
                }//HSTACK
            }
            
            Divider()
        }//VSTACK
    }
    
    private var castInfo: some View {
        VStack(alignment: .leading) {
            Text("CAST").foregroundColor(.white)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 20) {
                    ForEach(movieManager.cast) { cast in
                        VStack {
                            AsyncImage(url: URL(string: cast.profilePhoto)!) {
                                Rectangle().foregroundColor(Color.gray.opacity(0.4))
                            } image: { (img) -> Image in
                                Image(uiImage: img)
                                    .resizable()
                            }
                            .frame(width: 100, height: 160)
                            .animation(.easeInOut(duration: 0.5))
                            .transition(.opacity)
                            .scaledToFill()
                            .cornerRadius(15)
                            .shadow(radius: 15)
                            
                            Text("\(cast.name ?? "-") as \(cast.character ?? "-")")
                                .font(.caption)
                                .foregroundColor(.white)
                                .frame(width: 100)
                                .fixedSize(horizontal: false, vertical: true)
                        }//VSTACK
                    }
                }//HSTACK
            }
            
        }.onAppear {
            movieManager.getCast(for: movie)
        }//VSTACK
    }
}
