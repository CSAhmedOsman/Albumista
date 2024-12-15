//
//  ConfigurableCell.swift
//  Albumista
//
//  Created by Mac on 15/12/2024.
//

import Foundation

// MARK: - Protocol for Cell Configuration
protocol ConfigurableCell {
    associatedtype ItemType
    func configure(with item: ItemType)
}
