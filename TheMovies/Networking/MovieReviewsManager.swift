//
//  MovieReviewsManager.swift
//  TheMovies
//
//  Created by admin1 on 16.02.2022.
//

import SwiftUI

final class MovieReviewManager: ObservableObject {
    @Published var reviews = [Review]()
    private var movie: Movie
    static var baseURL = "https://api.themoviedb.org/3/movie/"
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func getMovieReviews() {
        
    }
    
    private func getReview(for movie: Movie) {
        let urlString = "\(Self.baseURL)\(movie.id ?? 100)/reviews?api_key=\(API.key)"
        NetworkManager<ReviewResponse>.fetch(from: urlString) { (result) in
            switch result {
            case .success(let response):
                self.reviews = response.results
            case .failure(let err):
                print(err)
            }
        }
    }
}
