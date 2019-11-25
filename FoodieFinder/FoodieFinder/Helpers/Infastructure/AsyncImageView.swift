//
//  AsyncImageView.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/24/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import UIKit

class AsyncImageView: UIImageView, ActivityIndicatorPresenter {
    var activityIndicator = UIActivityIndicatorView()
    
    func setNewImage(from url: URL, withPlaceholder placeholder: UIImage? = nil) {
        self.image = placeholder
        self.showActivityIndicator()
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error loading Image \(error.localizedDescription) ")
                DispatchQueue.main.async {
                    self.image = placeholder ?? #imageLiteral(resourceName: "cellGradientBackground")
                    self.hideActivityIndicator()
                }
            }
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                    self.hideActivityIndicator()
                }
            }
        }
        task.resume()
    }
}
