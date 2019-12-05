//
//  AsyncImageView.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/24/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import UIKit

/// UIImageView subclass. Fetches an image async and replaces the placeholder on the main thread. Includes the ActivityIndicatorPresenter in the center of the imageView (default). If false, no actvityIndicator 
class AsyncImageView: UIImageView, ActivityIndicatorPresenter {
    var activityIndicator = UIActivityIndicatorView()
    
    func setNewImage(from url: URL, withPlaceholder placeholder: UIImage? = nil, includeActivity: Bool = true) {
        self.image = placeholder
        includeActivity ? self.hideActivityIndicator() : nil
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error loading Image \(error.localizedDescription) ")
                DispatchQueue.main.async {
                    self.image = placeholder ?? #imageLiteral(resourceName: "cellGradientBackground")
                    includeActivity ? self.hideActivityIndicator() : nil
                }
            }
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                    includeActivity ? self.hideActivityIndicator() : nil
                }
            }
        }
        task.resume()
    }
}
