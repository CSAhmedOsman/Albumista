//
//  ProfileView.swift
//  Albumista
//
//  Created by Mac on 10/12/2024.
//

import UIKit

class ProfileView: UIView {
    
    @IBOutlet weak var contentView:UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetUp()
    }
    
    func xibSetUp() {
        contentView = loadViewFromNib()
        
        contentView.isUserInteractionEnabled = true
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        
    }
        
    func loadViewFromNib() -> UIView {
        let nib = Self.nib
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    func setUsernameAndImage(user: UserModel){
        usernameLabel.text = user.name ?? "User"
    }
}
