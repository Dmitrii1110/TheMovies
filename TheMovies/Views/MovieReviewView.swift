//
//  MovieReviewView.swift
//  TheMovies
//
//  Created by admin1 on 18.02.2022.
//

import SwiftUI

struct MovieReviewView: View {
    //MARK: - PROPERTIES
    
    var movie: Movie
    
    @ObservedObject var movieReviewMgr: MovieReviewManager
    
    init(movie: Movie) {
        self.movie = movie
        self.movieReviewMgr = MovieReviewManager(movie: movie)
        
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
        
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    //MARK: - BODY
    var body: some View {
        ZStack(alignment: .top) {
            Color.black.opacity(0.7)
            
            List {
                ForEach(movieReviewMgr.reviews) { review in
                    VStack {
                        Text(review.author ?? "")
                            .font(.title)
                            .bold()
                        Text(review.content ?? "")
                            .font(.body)
                            .lineLimit(nil)
                    }//VSTACK
                    .foregroundColor(.white)
                    .listRowBackground(Color.clear)
                    
                }
            }
            .onAppear {
                movieReviewMgr.getMovieReviews()
            }
            .padding(.horizontal, 32)
        }.edgesIgnoringSafeArea(.all)//ZSTACK
    }
}
