//
//  MainPresenter.swift
//  Unsplash_test
//
//  Created by Алексей Колыченков on 20.06.2025.
//

import Foundation

protocol MainScreenPresenterProtocol: AnyObject {
    init(view: MainScreenViewProtocol, networkService: NetworkServiceProtocol)
    var posts: [PostData]? {get}
    func getPosts()
}

final class MainScreenPresenter: MainScreenPresenterProtocol {
    
    weak var view: MainScreenViewProtocol?
    private let networkService: NetworkServiceProtocol
    private(set) var posts: [PostData]?
    
    
    init(view: MainScreenViewProtocol, networkService: NetworkServiceProtocol = NetworkService()) {
        self.view = view
        self.networkService = networkService
        getPosts()
    }
    
    func getPosts() {
        networkService.getPosts { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let decodedPosts):
                self.posts = decodedPosts
                DispatchQueue.main.async {
                    self.view?.showPost()
                }
            case .failure(let error):
                print("Failure: \(error)")
                DispatchQueue.main.async {
                    self.view?.showAlert(messageError: error.localizedDescription)
                }
            }
        }
    }
}
