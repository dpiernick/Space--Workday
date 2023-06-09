//
//  ResultsViewModel.swift
//  Space!
//
//  Created by Dave Piernick on 4/18/23.
//

import Foundation
import SwiftUI

protocol ResultsViewModelDelegate {
    func updateResults()
    func animateActivityIndicator(_ shouldAnimate: Bool)
}

class ResultsViewModel: ObservableObject {
    
    var delegate: ResultsViewModelDelegate?
    
    var searchTerm: String
    var pageToFetch = 1
    var totalItems = 1
    
    var items = [Item]() {
        didSet {
            delegate?.updateResults()
        }
    }
    
    var fetching = false {
        didSet {
            delegate?.animateActivityIndicator(fetching)
        }
    }
    
    init(searchTerm: String) {
        self.searchTerm = searchTerm
        Task { await fetchNextPage() }
    }
    
    func shouldFetch() -> Bool {
        return searchTerm != "" && pageToFetch <= 100 && items.count < totalItems
    }
    
    func encodedURL() -> URL? {
        if let encodedTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: "https://images-api.nasa.gov/search?q=\(encodedTerm)&media_type=image&page=\(pageToFetch)") {
            return url
        } else {
            return nil
        }
    }
    
    func fetchNextPage() async {
        guard shouldFetch(), let url = encodedURL() else { return }
        
        fetching = true
        do {
            let request = URLRequest(url: url)
            let (data, _) = try await URLSession.shared.data(for: request)
            let model = try JSONDecoder().decode(ResultsModel.self, from: data)
            items.append(contentsOf: model.collection?.items ?? [])
            fetching = false
            pageToFetch += 1
            totalItems = model.collection?.metadata?.total_hits ?? 0
        } catch {
            fetching = false
        }
    }
}
