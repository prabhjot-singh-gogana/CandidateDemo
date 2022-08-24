//
//  GiftListVC.swift
//  CandidateTest
//
//  Created by Prabhjot Singh Gogana on 21/8/2022.
//

import RxSwift
import RxCocoa

final class GiftListVC: UIViewController {
    private let disposeBag = DisposeBag()
    var giftListViewModel = GiftListVM()
    var tableViewGifts = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Gifts"
        bindUI()
        self.giftListViewModel.requestGiftData()
    }
    
    private func bindUI() {
        
        //uitableView Binding
        self.setupTableView()
        self.bindTableView()
        
        // binding loading to vc
        giftListViewModel.loading
            .filter({$0==true})
            .observe(on: MainScheduler.instance).subscribe { isLoading in
                self.giftListViewModel.giftList$.accept(self.giftListViewModel.emptyGiftList)
            }.disposed(by: disposeBag)
        
        
        // observing errors to show
        giftListViewModel
            .error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { (error) in
                switch error {
                case .internetError(let message):
                    print("Error - \(message)")
                case .serverMessage(let message):
                    print("Warning - \(message)")
                }
            })
            .disposed(by: disposeBag)
    }
    
    //binding the tableview datasource
    func bindTableView() {
        // binding the table with items
        self.giftListViewModel.giftList$.compactMap({$0}).bind(to: self.tableViewGifts.rx.items(cellIdentifier: String(describing: CellForGiftList.self), cellType: CellForGiftList.self)) {index, model,cell in
            cell.gift = model
        }.disposed(by: self.disposeBag)
        
        
        //        selection of row
        self.tableViewGifts.rx.modelSelected(Gift.self)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (gift) in
                //whole object here to show all the gifts on next screen
                self?.toDetailVC(gift: gift)
            }).disposed(by: self.disposeBag)
    }

    func toDetailVC(gift: Gift) {
        let detailVC = DetailOfGiftVC()
        detailVC.detailOfGiftVM.gift = gift
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //initialising the tableview and setup its constraints
    func setupTableView() {
        self.view.addSubview(self.tableViewGifts)
        self.tableViewGifts.backgroundColor = .white
        self.tableViewGifts.translatesAutoresizingMaskIntoConstraints = false
        self.tableViewGifts.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.tableViewGifts.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        self.tableViewGifts.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        self.tableViewGifts.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.tableViewGifts.separatorStyle = .none
        self.tableViewGifts.rowHeight = 180
        self.tableViewGifts.register(CellForGiftList.self, forCellReuseIdentifier: String(describing: CellForGiftList.self))
    }
}
