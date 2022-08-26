//
//  HeaderCardView.swift
//  CandidateTest
//
//  Created by Prabhjot Singh Gogana on 22/8/2022.
//


import UIKit
import RxSwift
import RxCocoa

class HeaderCardView: UIView {
    
    var gift: Gift? {
        didSet {
            guard let giftItem = gift else {return}
            if let brand = giftItem.brand {
                lblName.text = brand
            }
            if let imageURL = giftItem.image {
                self.giftImageView.loadImage(fromURL: imageURL)
            }
            if let discount = giftItem.discount {
                lblDiscount.text = "Discount \(discount)"
            }
        }
    }
    
    let giftImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.clipsToBounds = true
        return img
    }()
    
    let lblName:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 1
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lblDiscount:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 1
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(giftImageView)
        self.addSubview(self.lblName)
        self.addSubview(self.lblDiscount)
        self.giftImageView.topAnchor.constraint(equalTo:self.topAnchor, constant: 18).isActive = true
        self.giftImageView.centerXAnchor.constraint(equalTo:self.centerXAnchor, constant:0).isActive = true
        self.giftImageView.centerYAnchor.constraint(equalTo:self.centerYAnchor, constant:-20).isActive = true
        self.giftImageView.widthAnchor.constraint(equalTo:self.giftImageView.heightAnchor, multiplier: (2/1) , constant:0).isActive = true
        
        self.lblName.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant: 8).isActive = true
        self.lblName.bottomAnchor.constraint(equalTo:self.bottomAnchor, constant: -8).isActive = true
        
        self.lblDiscount.trailingAnchor.constraint(equalTo:self.trailingAnchor, constant: -8).isActive = true
        self.lblDiscount.bottomAnchor.constraint(equalTo:self.bottomAnchor, constant: -8).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
