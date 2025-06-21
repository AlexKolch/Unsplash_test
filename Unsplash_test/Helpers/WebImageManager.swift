//
//  WebImageManager.swift
//  Unsplash_test
//
//  Created by Алексей Колыченков on 21.06.2025.
//

import UIKit

final class WebImageManager: UIImageView {
    ///Загрузить изображение из сети или кэша
    func set(imageUrl: String, completion: @escaping () -> ()) {
        guard let url = URL(string: imageUrl) else {
            let placeholderImage = UIImage(systemName: "photo") //заглушка если нет фотографии
            self.image = placeholderImage
            completion()
            return
        }
        
        if let cashedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            DispatchQueue.main.async {
                self.image = UIImage(data: cashedResponse.data)
                completion()
            }
        } else {
            let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                DispatchQueue.main.async {
                    if let data = data, let response = response {
                        self?.image = UIImage(data: data)
                        self?.cashingImage(data: data, response: response)
                        completion()
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    ///Создание кэша
    private func cashingImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else {return}
        
        let cashedResponse = CachedURLResponse(response: response, data: data)
        
        URLCache.shared.storeCachedResponse(cashedResponse, for: URLRequest(url: responseURL))
    }
}
