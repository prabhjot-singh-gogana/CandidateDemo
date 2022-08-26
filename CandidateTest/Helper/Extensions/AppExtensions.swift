//
//  ExtensionViews.swift
//  ArticleDemo
//
//  Created by Prabhjot Singh Gogana on 14/7/22.
//

import UIKit

// protocol created to not use extra parameters for identifier

public extension UIImageView {
    // used for caching the images
    
    func loadImage(fromURL url: String) {
        guard let imageURL = URL(string: url) else {
            return
        }
        
        let cache =  URLCache.shared
        let request = URLRequest(url: imageURL)
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.transition(toImage: image)
                }
            } else {
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        DispatchQueue.main.async {
                            self.transition(toImage: image)
                        }
                    }
                }).resume()
            }
        }
    }
    
    func transition(toImage image: UIImage?) {
        UIView.transition(with: self, duration: 0.3,
                          options: [.transitionCrossDissolve],
                          animations: {
                            self.image = image
        },
                          completion: nil)
    }
}

extension UserDefaults {

    static func setAddToCart(_ object: [Gift]) {
        let objectData = try? PropertyListEncoder().encode(object)
        UserDefaults.standard.set(objectData, forKey: "giftCart")
        UserDefaults.standard.synchronize()
    }
    static func getCart() -> [Gift]? {
        if let objectData = UserDefaults.standard.object(forKey: "giftCart") as? Data {
            let object = try? PropertyListDecoder().decode(Array<Gift>.self, from: objectData)
            return object
        }
        return nil
    }
}

extension UIAlertController {
    static func alert(title: String? = nil, message: String? = nil, okTap: (() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title ?? "Alert", message: message ?? "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
            okTap?()
        }))
        
        return alert
    }
}
