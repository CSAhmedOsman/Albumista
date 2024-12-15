//
//  CollectionViewHandler.swift
//  Albumista
//
//  Created by Mac on 15/12/2024.
//

import UIKit

class CollectionViewHandler<Item, Cell: UICollectionViewCell>: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout where Cell: ConfigurableCell, Item == Cell.ItemType {
    
    private let reuseIdentifier = String(describing: Cell.self)

    var items: [Item]
    private var collectionView: UICollectionView
    
    var didSelectItem: ((Item) -> Void)?
    
    init(_ collectionView: UICollectionView, items: [Item], layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout(), minimumLineSpacing: CGFloat = 8, minimumInteritemSpacing: CGFloat = 8, target: Any? = nil, refreshAction: Selector? = nil, for controlEvents: UIControl.Event = .valueChanged) {
        self.items = items
        self.collectionView = collectionView
        
        super.init()
        let width = (collectionView.frame.width - (2 * 8)) / 3
        let cellSize: CGSize = CGSize(width: width, height: width)
        // Configure collection view layout
        layout.itemSize = cellSize
        layout.minimumLineSpacing = minimumLineSpacing
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        collectionView.collectionViewLayout = layout
        
        // Configure collection view
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        
        collectionView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        if let refreshAction, let target {
            addRefresherToTableView(target, action: refreshAction, for: controlEvents)
        }
    }

    private func addRefresherToTableView(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .systemBlue
        collectionView.refreshControl = refreshControl
        collectionView.refreshControl?.addTarget(target, action: action, for: controlEvents)
    }
    
    func stopLoading() {
        collectionView.refreshControl?.endRefreshing()
    }

    // MARK: - Data Management
    func didMoreItemsLoaded(items: [Item], at index: Int? = nil) {
        if let index, index >= 0, index < self.items.count {
            self.items.insert(contentsOf: items, at: index)
        } else {
            self.items.append(contentsOf: items)
        }

        collectionView.reloadData()
        stopLoading()
    }
    
    func didItemsChanged(with newItems: [Item]) {
        self.items = newItems
        collectionView.reloadData()
        stopLoading()
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: Cell.self), for: indexPath) as! Cell
        
        let item = items[indexPath.row]
        cell.configure(with: item)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.row]
        didSelectItem?(selectedItem)
    }
}
