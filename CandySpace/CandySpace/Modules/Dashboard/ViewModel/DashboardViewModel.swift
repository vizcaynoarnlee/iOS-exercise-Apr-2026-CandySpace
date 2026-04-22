//
//  DashboardViewModel.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import Foundation

protocol DashboardViewProtocol {
    var viewState: ViewState { get }
    
    func loadMedia() async
}

@Observable
final class DashboardViewModel: DashboardViewProtocol {
    private var apiClient: APIClientProtocol
    
    var viewState: ViewState = .initial
    
    var media: Media?
    var isMediaEmpty: Bool { media?.record.sections.isEmpty ?? true }
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func loadMedia() async {
        guard viewState != .loading else { return }
        
        viewState = .loading
        
        do {
            // Check for cancellation
            guard Task.isCancelled == false else { return }
            
            let media: Media? = try await apiClient.get(endpoint: MediaRequestEndpoint.getMedia)
            
            // Check for cancellation
            guard Task.isCancelled == false else { return }
            
            self.media = media
            viewState = .loaded
        } catch {
            // Check for cancellation
            guard Task.isCancelled == false else { return }
            viewState = .error(error)
        }
    }
}
