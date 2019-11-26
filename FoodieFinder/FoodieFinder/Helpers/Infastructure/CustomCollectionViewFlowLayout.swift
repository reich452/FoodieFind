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
    case grid(columns: Int)
}

extension CollectionDisplay: Equatable {
    
    public static func == (lhs: CollectionDisplay, rhs: CollectionDisplay) -> Bool {
        
        switch (lhs, rhs) {
        case (.inline, .inline),
             (.list, .list):
            return true
            
        case (.grid(let lColumn), .grid(let rColumn)):
            return lColumn == rColumn
            
        default:
            return false
        }
    }
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
    
    var display: CollectionDisplay = .list {
        didSet {
            if display != oldValue {
                self.invalidateLayout()
            }
        }
    }
    
    var containerWidth: CGFloat = 0.0 {
        didSet {
            if containerWidth != oldValue {
                self.invalidateLayout()
            }
        }
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        self.configLayout()
    }
    
    // MARK: - Init
    
    convenience init(display: CollectionDisplay, containerWidth: CGFloat, lineSpace: CGFloat = 10, interItemSpace: CGFloat = 10) {
        self.init()
        
        self.display = display
        self.containerWidth = containerWidth
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
            
        case .grid(let column):
            
            self.scrollDirection = .vertical
            let spacing = CGFloat(column - 1) * minimumLineSpacing
            let optimisedWidth = (containerWidth - spacing) / CGFloat(column)
            self.itemSize = CGSize(width: optimisedWidth, height: optimisedWidth) // keep as squareuare
            
        case .list:
            self.scrollDirection = .vertical
            self.scrollDirection = .vertical
            self.itemSize = CGSize(width: containerWidth, height: 180)
            
        }
    }
}
