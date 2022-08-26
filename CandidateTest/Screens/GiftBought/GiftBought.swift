//
//  GiftBought.swift
//  CandidateTest
//
//  Created by Prabhjot Singh Gogana on 26/8/2022.
//

import RxCocoa
import RxSwift

class GiftBought: UIViewController {

    var gift: Gift?
    private var disposeBag = DisposeBag()
    
    private let lblTitle:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let btnToHome:UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle(AppConstants.strContShop, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let lblCongrats:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.numberOfLines = 1
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lblDenomination:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    // view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        bindingViewComp()
        setupConstraints()
    }
    
    // Adding subviews and binding with gift card model
    private func bindingViewComp() {
        self.view.addSubview(self.lblCongrats)
        self.view.addSubview(self.lblTitle)
        self.view.addSubview(self.lblDenomination)
        self.view.addSubview(self.btnToHome)
        
        self.lblCongrats.text = AppConstants.strCongo
        guard let giftItem = gift else {return}
        if let brand = giftItem.brand {
            self.lblTitle.text = String(format: AppConstants.strBoughtGiftCard, arguments: [brand])
        }
        if let denomination = giftItem.denominations?.filter({$0.isSelected == true}).first {
            self.lblDenomination.text = String(format: AppConstants.strSelectedDenomPrice, arguments: [denomination.price ?? 0.0])
        }
        self.btnToHome.rx.tap.bind { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }.disposed(by: self.disposeBag)
    }

    // All Constraints are setup here
    private func setupConstraints() {
        self.lblCongrats.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        self.lblCongrats.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        
        self.lblTitle.topAnchor.constraint(equalTo: self.lblCongrats.bottomAnchor, constant: 30).isActive = true
        self.lblTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.lblTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
        self.lblDenomination.topAnchor.constraint(equalTo: self.lblTitle.bottomAnchor, constant: 35).isActive = true
        self.lblDenomination.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        
        self.btnToHome.topAnchor.constraint(equalTo: self.lblDenomination.bottomAnchor, constant: 35).isActive = true
        self.btnToHome.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.btnToHome.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.btnToHome.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        
    }
}
