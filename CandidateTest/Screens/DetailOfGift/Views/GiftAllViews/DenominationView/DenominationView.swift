//
//  DenominationView.swift
//  CandidateTest
//
//  Created by Prabhjot Singh Gogana on 23/8/2022.
//


import RxSwift
import RxCocoa

class DenominationView: UIView {
    
    private var bag = DisposeBag()
    private var denominations = [Denomination]()
    
    private let collectionView:UICollectionView = {
        // create a layout to be used
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        // set a standard item size of 60 * 60
        layout.itemSize = CGSize(width: 100, height: 40)
        // the layout scrolls horizontally
        layout.scrollDirection = .horizontal
        // set the frame and layout
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        // set the view to be this UICollectionView
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let lblSectionTitle:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 1
        label.textColor = .black
        label.text = "Denominations"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.collectionView)
        self.addSubview(self.lblSectionTitle)
        
        self.lblSectionTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        self.lblSectionTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        self.collectionView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo:self.bottomAnchor, constant: 0).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant: 0).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo:self.trailingAnchor, constant: 0).isActive = true
        self.collectionView.register(CellForPrice.self, forCellWithReuseIdentifier: String(describing: CellForPrice.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    this public method to add all denominations to collection view and also calls back the denominations with isSelected true
    func setDenominations(_ denominations: [Denomination], selectDenominationHandler: @escaping (([Denomination]) -> ())) {
        self.denominations = denominations
        let denom = BehaviorSubject<[Denomination]>.init(value: denominations)
        denom.bind(to: self.collectionView.rx.items(cellIdentifier: String(describing: CellForPrice.self), cellType: CellForPrice.self)) { row, element, cell in
            cell.denomination = element
        }.disposed(by: self.bag)
        
        self.collectionView.rx.itemSelected
            .subscribe(on: MainScheduler.instance)
            .subscribe (onNext: { [weak self] indexPath in
                guard let _self = self else {return}
                for (row, _) in _self.denominations.enumerated(){
                    _self.denominations[row].isSelected = false
                }
                _self.denominations[indexPath.row].isSelected = true
                denom.onNext(_self.denominations)
                selectDenominationHandler(_self.denominations)
            }).disposed(by: self.bag)
    }

}

//collection view cell which will show the price on cell
fileprivate class CellForPrice: UICollectionViewCell {
    
    var denomination: Denomination? {
        didSet {
            guard let object = denomination else {return}
            if let price = object.price {
                lblPrice.text = "\(price)"
            }
            if let selected = object.isSelected {
                self.contentView.backgroundColor = (selected) ? .systemBlue : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }
        }
    }
    
    private var lblPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 1
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(lblPrice)
        self.contentView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        lblPrice.centerXAnchor.constraint(equalTo:self.centerXAnchor, constant: 0).isActive = true
        lblPrice.centerYAnchor.constraint(equalTo:self.centerYAnchor, constant: 0).isActive = true
    }
}
