//
//  CellForGiftList.swift
//  CandidateTest
//
//  Created by Prabhjot Singh Gogana on 21/8/2022.
//

import UIKit


class CellForGiftList: UITableViewCell {
    
    var gifts: Gift? {
        didSet {
            guard let giftItem = gifts else {return}
            if let brand = giftItem.brand {
                lblName.text = brand
            }
            if let discount = giftItem.discount {
                lblDiscount.text = " \(discount) "
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
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lblDiscount:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .white
        label.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.layer.cornerRadius = 5
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.clipsToBounds = true
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(giftImageView)
        self.contentView.addSubview(lblName)
        self.contentView.addSubview(lblDiscount)
        
        giftImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        giftImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        giftImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        giftImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        lblName.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant: 5).isActive = true
        lblName.leadingAnchor.constraint(equalTo:self.giftImageView.trailingAnchor, constant: 10).isActive = true
        lblName.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant: -10).isActive = true
        lblName.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        lblDiscount.topAnchor.constraint(equalTo:self.lblName.bottomAnchor, constant: 5).isActive = true
        lblDiscount.leadingAnchor.constraint(equalTo:self.giftImageView.trailingAnchor, constant: 10).isActive = true
        lblDiscount.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant: -10).isActive = true
        lblDiscount.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: -10).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }

}
