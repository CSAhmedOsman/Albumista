//
//  AlbumTableViewCell.swift
//  Albumista
//
//  Created by Mac on 14/12/2024.
//

import UIKit

class AlbumTableViewCell: UITableViewCell, ConfigurableCell {
        
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with item: AlbumModel) {
        titleLabel.text = item.title?.capitalized
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let gradientLayer: CAGradientLayer
        // Ensure the gradient layer matches the content view bounds
        let frame =  CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y + 4, contentView.bounds.width, contentView.bounds.height - 8)
        
        if let firstGradientLayer = contentView.layer.sublayers?.first(where: { $0 is CAGradientLayer }) as? CAGradientLayer {
            gradientLayer = firstGradientLayer
            gradientLayer.frame = frame
        } else {
            gradientLayer = randomGradient()
            gradientLayer.frame = frame
            gradientLayer.cornerRadius = 8
            contentView.layer.insertSublayer(gradientLayer, at: 0)
        }
        
        // Update label's text color based on gradient
        titleLabel.textColor = bestTextColor(from: gradientLayer)
    }

    func randomGradient() -> CAGradientLayer {
        // Create a gradient layer
        let gradientLayer = CAGradientLayer()
        
        // Generate a base color
        let baseRed = CGFloat.random(in: 0.4...1.0) // Avoid overly dark colors
        let baseGreen = CGFloat.random(in: 0.4...1.0)
        let baseBlue = CGFloat.random(in: 0.4...1.0)
        
        let baseColor = UIColor(red: baseRed, green: baseGreen, blue: baseBlue, alpha: 1.0)
        
        // Generate a second color that's analogous or complementary
        let offset = CGFloat.random(in: -0.2...0.2) // Small variation
        let secondaryColor = UIColor(
            red: min(max(baseRed + offset, 0), 1),
            green: min(max(baseGreen - offset, 0), 1),
            blue: min(max(baseBlue + offset * 1.5, 0), 1),
            alpha: 1.0
        )
        
        // Set the colors for the gradient
        gradientLayer.colors = [baseColor.cgColor, secondaryColor.cgColor]
        
        // Set a smooth, pleasing gradient direction
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0) // Top-left
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)   // Bottom-right
        
        return gradientLayer
    }
    
    func bestTextColor(from gradientLayer: CAGradientLayer) -> UIColor {
        // Extract the red, green, and blue components of the color
        guard let firstColor = gradientLayer.colors?.first else { return .black }
        let backgroundColor = UIColor(cgColor: firstColor as! CGColor)
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        backgroundColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Calculate the perceived brightness of the color
        let brightness = (red * 299 + green * 587 + blue * 114) / 1000
        
        // Return white text for dark backgrounds, and black text for light backgrounds
        return brightness > 0.5 ? .black : .white
    }
    
}
