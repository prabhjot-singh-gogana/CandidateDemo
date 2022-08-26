//
//  AddButtonView.swift
//  CandidateTest
//
//  Created by Prabhjot Singh Gogana on 25/8/2022.
//

import RxSwift
import RxCocoa

class AddButtonView: UIView {
    
    var onTapAddToCart: (()->())? //whenever button add to cart gets tap this block get called
    var onTapBuyNow: (()->())? //whenever button buy now gets tap block get called
    private let bag = DisposeBag()
    
    // private object of button to add to cart
    private let btnAddtoCart: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle(AppConstants.strAddToCart, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // private object of button to BUY NOW
    private let btnBuyNow: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle(AppConstants.strBuyNow, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // initialise method
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bindingViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Adding subviews and binding with tap blocks
    func bindingViews() {
        self.addSubview(self.btnBuyNow)
        self.addSubview(self.btnAddtoCart)
        
        self.btnBuyNow.rx.tap.bind{[weak self] in
            self?.onTapBuyNow?()
        }.disposed(by: self.bag)
        
        self.btnAddtoCart.rx.tap.bind{[weak self] in
            self?.onTapAddToCart?()
        }.disposed(by: self.bag)
    }
    
    // All Constraints are setup here
    func setupConstraints() {
        self.btnBuyNow.topAnchor.constraint(equalTo:self.topAnchor, constant: 18).isActive = true
        self.btnBuyNow.centerXAnchor.constraint(equalTo:self.centerXAnchor, constant:0).isActive = true
        self.btnBuyNow.widthAnchor.constraint(equalToConstant: 240).isActive = true
        self.btnBuyNow.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.btnAddtoCart.bottomAnchor.constraint(equalTo:self.bottomAnchor, constant: -18).isActive = true
        self.btnAddtoCart.centerXAnchor.constraint(equalTo:self.centerXAnchor, constant:0).isActive = true
        self.btnAddtoCart.widthAnchor.constraint(equalToConstant: 240).isActive = true
        self.btnAddtoCart.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
