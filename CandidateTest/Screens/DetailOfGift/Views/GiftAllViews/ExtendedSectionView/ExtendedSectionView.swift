//
//  ExtendedSectionView.swift
//  CandidateTest
//
//  Created by Prabhjot Singh Gogana on 25/8/2022.
//

import UIKit

class ExtendedSectionView: UITableViewHeaderFooterView {
    
    // binding the title with lblTitle
    var title: String? {
        didSet {
            guard let value = title else {return}
            lblTitle.text = value
        }
    }
//    when isOpened change image arrow will rotate to 45 degree
    var isOpened = false {
        didSet {
            self.imgViewArrow.transform = isOpened ? self.imgViewArrow.transform.rotated(by: .pi/2) : CGAffineTransform.identity
        }
    }
    var handlerOnTap: (()->())?
        
    private let lblTitle:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 1
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imgViewArrow:UIImageView = {
        let img = UIImageView(image: UIImage(systemName: "arrow.right"))
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.clipsToBounds = true
        return img
    }()
    
    
    @objc private func didSelect() {
        self.handlerOnTap?()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        bindingView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Adding subviews and binding tap gesture
    private func bindingView() {
        self.addSubview(self.lblTitle)
        self.addSubview(self.imgViewArrow)
        
        let hideGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didSelect))
        self.addGestureRecognizer(hideGestureRecognizer)
    }
    
    // All Constraints are setup here
    private func setupConstraints() {
        self.lblTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        self.lblTitle.centerYAnchor.constraint(equalTo:self.centerYAnchor, constant:0).isActive = true
        
        self.imgViewArrow.centerYAnchor.constraint(equalTo:self.centerYAnchor, constant:0).isActive = true
        self.imgViewArrow.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18).isActive = true
        self.imgViewArrow.widthAnchor.constraint(equalToConstant: 26).isActive = true
        self.imgViewArrow.heightAnchor.constraint(equalToConstant: 26).isActive = true
    }
    
    
}
