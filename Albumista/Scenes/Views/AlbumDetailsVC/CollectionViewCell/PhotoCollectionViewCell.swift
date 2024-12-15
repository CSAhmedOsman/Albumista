//
//  PhotoCollectionViewCell.swift
//  Albumista
//
//  Created by Mac on 15/12/2024.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell, ConfigurableCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Initialization
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.sd_cancelCurrentImageLoad()
        imageView.image = nil
        titleLabel.text = nil
    }
    
    // MARK: - UI Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.layer.cornerRadius = 8
        titleLabel.layer.cornerRadius = 4
    }
    
    // MARK: - Configuration
    func configure(with item: PhotoModel) {
        let url = URL(string: item.thumbnailUrl ?? "")
        imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        
        titleLabel.text = item.title?.capitalized ?? ""
    }
}
