//
//  TableViewHandler.swift
//  Albumista
//
//  Created by Mac on 14/12/2024.
//

import UIKit

class TableViewHandler<Item, Cell: UITableViewCell>: NSObject, UITableViewDataSource, UITableViewDelegate where Cell: ConfigurableCell, Item == Cell.ItemType {
    
    private let reuseIdentifier = String(describing: Cell.self)

    var items: [Item]
    private var tableView: UITableView
    
    var didSelectItem: ((Item) -> Void)?
    
    init(_ tableView: UITableView, items: [Item], rowHeight: CGFloat = UITableView.automaticDimension, isScrollEnabled: Bool = true, separatorStyle: UITableViewCell.SeparatorStyle = .singleLine, target: Any? = nil, refreshAction: Selector? = nil, for controlEvents: UIControl.Event = .valueChanged) {
        
        self.items = items
        self.tableView = tableView
        
        super.init()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = separatorStyle
        tableView.isScrollEnabled = isScrollEnabled
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = rowHeight
        
        tableView.tableFooterView = nil
        
        tableView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        
        if let refreshAction, let target {
            addRefresherToTableView(target, action: refreshAction, for: controlEvents)
        }
    }
    
    private func addRefresherToTableView(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .systemBlue
        tableView.refreshControl = refreshControl
        tableView.refreshControl?.addTarget(target, action: action, for: controlEvents)
    }

    func stopLoading() {
        tableView.refreshControl?.endRefreshing()
    }

    func didMoreItemsLoaded(items: [Item], at index: Int? = nil){
        if let index, index >= 0, index < self.items.count {
            self.items.insert(contentsOf: items, at: index)
        }else {
            self.items.append(contentsOf: items)
        }
        
        tableView.reloadData()
        stopLoading()
    }
    
    func didItemsChanged(with newItems: [Item]){
        self.items = newItems
        tableView.reloadData()
        stopLoading()
    }
    
    // TODO: View If the items is Empty
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the count based on the data you're working with
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Determine which data and cell identifier to use
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! Cell
        let item = items[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.row]
        didSelectItem?(selectedItem)
    }
}
