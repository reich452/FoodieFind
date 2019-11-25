//
//  UIImageView+Extention.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/24/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(from url: URL, withPlaceholder placeholder: UIImage? = nil) {
        self.image = placeholder
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error loading Image \(error.localizedDescription) ")
                DispatchQueue.main.async {
                    self.image = placeholder ?? #imageLiteral(resourceName: "cellGradientBackground")
                }
            }
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
        task.resume()
    }
}
