//
//  ImageLoader.swift
//  TheMovies
//
//  Created by admin1 on 16.02.2022.
//

import Combine
import UIKit

final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private(set) var isLoading = false
    
    private let url: URL
    private let cache: ImageCache?
    private var cancellable: AnyCancellable?
    
    private static let imageProccessingQueue = DispatchQueue(label: "image-processing")
    
    init(url: URL, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
        
    }
    
    deinit {
        cancel()
    }
    
    func cancel() {
        cancellable?.cancel()
    }
    
    func load() {
        guard !isLoading else {
            return
        }
        
        if let image = cache? [url] {
            self.image = image
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map {UIImage(data: $0.data)}
            .replaceError(with: nil)
            .handleEvents(receiveSubscription: {[weak self] in self?.onStart()},
                receiveOutput: {[weak self] in self?.cache($0)},
                receiveCompletion: {[weak self] _ in self?.onFinish()},
                receiveCancel: {[weak self] _ in self?.onFinish()},
                receiveRequest: { [weak self] _ in self?.onFinish()})
            .subscribe(on: self.imageProcessingQueue)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0}
    }
                          
    private func onStart() {
                isLoading = true
                
    }
                          
    private func onFinish() {
        isLoading = false
    }
    
    private func cache(_ image: UIImage?) {
        image.map { cache?[url] = $0}
    }
}
