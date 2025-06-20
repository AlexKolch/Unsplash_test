//
//  MainPresenter.swift
//  Unsplash_test
//
//  Created by Алексей Колыченков on 20.06.2025.
//

import Foundation

protocol MainScreenPresenterProtocol: AnyObject {
    init(view: MainScreenViewProtocol, networkService: NetworkServiceProtocol)
    var posts: [PostData]? {get set}
    func getPosts()
}

final class MainScreenPresenter: MainScreenPresenterProtocol {
    weak var view: MainScreenViewProtocol?
    private let networkService: NetworkServiceProtocol
    var posts: [PostData]?
    
    init(view: MainScreenViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getPosts()
    }
    
    func getPosts() {
        //
    }
}
