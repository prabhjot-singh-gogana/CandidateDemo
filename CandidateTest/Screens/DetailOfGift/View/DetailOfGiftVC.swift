//
//  DetailOfGiftVC.swift
//  CandidateTest
//
//  Created by Prabhjot Singh Gogana on 21/8/2022.
//


import RxSwift
import RxCocoa

class DetailOfGiftVC: UIViewController {
    private let disposeBag = DisposeBag()
    var detailOfGiftVM = DetailOfGiftVM()
    var tableViewGift = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Gifts"
        self.setupTableView()
    }
    
    //initialising the tableview and setup its constraints
    func setupTableView() {
        self.view.addSubview(self.tableViewGift)
        self.tableViewGift.delegate = self
        self.tableViewGift.dataSource = self
        self.tableViewGift.backgroundColor = .white
        self.tableViewGift.translatesAutoresizingMaskIntoConstraints = false
        self.tableViewGift.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.tableViewGift.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        self.tableViewGift.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        self.tableViewGift.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.tableViewGift.separatorStyle = .none
 
    }
    
    func headerView() -> HeaderCardView {
        let headerView = HeaderCardView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0))
        headerView.gift = detailOfGiftVM.gift
        return headerView
    }
    
    func denominationView() -> DenominationView {
        let denominationView = DenominationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: DetailOfGiftVM.SectionType.denomination.heightForSection))
        denominationView.setDenominations(self.detailOfGiftVM.gift?.denominations ?? []) { denomination in
            print(denomination)
        }
        return denominationView
    }
}

extension DetailOfGiftVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.detailOfGiftVM.sectionTypes.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.detailOfGiftVM.sectionTypes[section].heightForSection
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch self.detailOfGiftVM.sectionTypes[section] {
        case .header:
            return self.headerView()
        case .denomination:
            return self.denominationView()
        case .buttons:
            return self.headerView()
        case .terms:
            return self.headerView()
        case .disclaimer:
            return self.headerView()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell \(indexPath.row)", for: indexPath)
        return cell
    }
}
