//
//  CustomCollectionViewFlowLayout.swift
//  FoodieFinder
//
//  Created by Nick Reichard on 11/24/19.
//  Copyright © 2019 NickReichard. All rights reserved.
//

import UIKit

enum CollectionDisplay {
    /// Horizontal Layout
    case inline
    /// One item per row
    case list
    /// More than one item per row
    case grid
}

protocol CollectionItemSize {
    var itemWith: CGFloat { get set }
    var itemHeight: CGFloat { get set }
}

/// Reusable class for FlowLayouts - inline, list, or, grid
class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout, CollectionItemSize {
    
    // MARK: - Properties
    
    var itemWith: CGFloat = 0.0
    var itemHeight: CGFloat = 0.0
    
    var display: CollectionDisplay = .grid {
        didSet {
            if display != oldValue {
                self.invalidateLayout()
            }
        }
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        self.configLayout()
    }
    
    // MARK: - Init
    
    convenience init(itemWith: CGFloat, itemHeight: CGFloat, lineSpace: CGFloat = 10, interItemSpace: CGFloat = 10) {
        self.init()
        self.itemWith = itemWith
        self.itemHeight = itemHeight
        self.minimumLineSpacing = lineSpace
        self.minimumInteritemSpacing = interItemSpace
        self.configLayout()
    }
    
    convenience init(display: CollectionDisplay, lineSpace: CGFloat = 10, interItemSpace: CGFloat = 10) {
        self.init()
        
        self.display = display
        self.minimumLineSpacing = lineSpace
        self.minimumInteritemSpacing = interItemSpace
        self.configLayout()
    }
    
    // MARK: - Main
    
    func configLayout() {
        switch display {
        case .inline:
            self.scrollDirection = .horizontal
            guard let collectionView = collectionView else { return }
            if self.itemHeight > 0 && self.itemWith > 0 {
                self.itemSize = CGSize(width: collectionView.frame.width * itemWith, height: itemHeight)
            } else {
                self.itemSize = CGSize(width: collectionView.frame.width * 0.9, height: 300)
            }
            
        case .grid:
            
            self.scrollDirection = .vertical
            if let collectionView = self.collectionView {
                let optimisedWidth = (collectionView.frame.width - minimumInteritemSpacing) / 2
                self.itemSize = CGSize(width: optimisedWidth, height: optimisedWidth) // keep as square
            }
            
        case .list:
            self.scrollDirection = .vertical
            if let collectionView = self.collectionView {
                if self.itemHeight != 0.0 {
                    self.itemSize = CGSize(width: collectionView.frame.width, height: itemHeight)
                } else {
                    self.itemSize = CGSize(width: collectionView.frame.width, height: 180)
                }
            }
        }
    }
}
