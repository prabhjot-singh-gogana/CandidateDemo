//
//  CellForGiftList.swift
//  CandidateTest
//
//  Created by Prabhjot Singh Gogana on 21/8/2022.
//

import UIKit


class CellForGiftList: UITableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var gift: Gift? {
        didSet {
            guard let giftItem = gift else {return}
            if let brand = giftItem.brand {
                lblName.text = brand
            }
            if let imageURL = giftItem.image {
                self.giftImageView.loadImage(fromURL: imageURL)
            }
        }
    }
    
    let giftImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 5
        img.clipsToBounds = true
        return img
    }()
    
    let lblName:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 1
        label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(giftImageView)
        self.contentView.addSubview(lblName)

        giftImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        giftImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:0).isActive = true
        giftImageView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:0).isActive = true
        giftImageView.heightAnchor.constraint(equalToConstant:150).isActive = true
        
        lblName.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        lblName.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:0).isActive = true
        lblName.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:0).isActive = true
        lblName.heightAnchor.constraint(equalToConstant:40).isActive = true
    }
    
}
