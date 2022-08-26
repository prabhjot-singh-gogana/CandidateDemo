//
//  DetailOfGiftVC.swift
//  CandidateTest
//
//  Created by Prabhjot Singh Gogana on 21/8/2022.
//


import RxSwift
import RxCocoa

class DetailOfGiftVC: UIViewController{
    
    private let disposeBag = DisposeBag()
    var detailOfGiftVM = DetailOfGiftVM()
    var tableViewGift = UITableView(frame: .zero, style: .grouped)
    // Views of the sections. However we can add the view directly by methods of protocols
    var denominationView: DenominationView!
    var headerView: HeaderCardView!
    var disclamerView: ExtendedSectionView!
    var termsView: ExtendedSectionView!
    var addbuttonsView: AddButtonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Gifts"
        self.bindingViews()
        self.setupTableView()
    }
    
    // Adding subviews and binding the views from protocols method
    func bindingViews() {
        guard let gift = self.detailOfGiftVM.gift else {return}
        self.headerView = headerView(gift: gift)
        if let tempDenom = self.detailOfGiftVM.gift?.denominations, tempDenom.count > 0 {
            self.detailOfGiftVM.gift?.denominations![0].isSelected = true // Initially first denomination is selected
        }
        self.denominationView = denominationView(denominations: self.detailOfGiftVM.gift?.denominations ?? [])
        self.addbuttonsView = buttonsView()
        self.termsView = termsAndConditionSectionViewbale(title: AppConstants.strTerms)
        self.disclamerView = disclaimerSectionViewbale(title: AppConstants.strDisc)
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
}

// All protocols methods defined in extesnion of DetailOfGiftVC
extension DetailOfGiftVC: UITableViewDelegate, UITableViewDataSource, DenominationViewable, AddButtonViewable, GiftHeaderViewble, DisclaimerSectionViewbale, TermsSectionViewbale  {
    
// return the count of section types as sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.detailOfGiftVM.sectionTypes.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.detailOfGiftVM.sectionTypes[section].heightForSection
    }
//    returning headerView according to section types
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch self.detailOfGiftVM.sectionTypes[section] {
        case .header:
            return self.headerView
        case .denomination:
            return self.denominationView
        case .buttons:
            return self.addbuttonsView
        case .terms:
            return self.termsView
        case .disclaimer:
            return self.disclamerView
        }
    }
    
//    only disclaimer and terms have one cell defines in section types
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.detailOfGiftVM.sectionTypes[section].rowsInSection
    }
    
//    changing the height of cells section isOpened or not
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = self.detailOfGiftVM.sectionTypes[indexPath.section]
        if sectionType == .disclaimer {
            if let sectionView = tableView.headerView(forSection: indexPath.section) as? ExtendedSectionView {
                return sectionView.isOpened ? UITableView.automaticDimension : 0
            }
        } else if sectionType == .terms {
            if let sectionView = tableView.headerView(forSection: indexPath.section) as? ExtendedSectionView {
                return sectionView.isOpened ? UITableView.automaticDimension : 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
// using default cell which textLabel which gonna be depricated in future. binding disclamer and terms text in the cell according to the type
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let sectionType = self.detailOfGiftVM.sectionTypes[indexPath.section]
        let text = (sectionType == .disclaimer) ? (self.detailOfGiftVM.gift?.disclaimer ?? "") : (self.detailOfGiftVM.gift?.terms ?? "")
        cell.textLabel?.text = text
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
// this protocol rule gets called when disclamer section gets tapped
    func onDisclaimerTap() {
        self.disclamerView.isOpened = !self.disclamerView.isOpened
        self.tableViewGift.reloadRows(at: [IndexPath(row: 0, section: DetailOfGiftVM.SectionType.disclaimer.rawValue)], with: .fade)
    }

// this protocol rule gets called when terms section gets tapped
    func onTermsTap() {
        self.termsView.isOpened = !self.termsView.isOpened
        self.tableViewGift.reloadRows(at: [IndexPath(row: 0, section: DetailOfGiftVM.SectionType.terms.rawValue)], with: .fade)
    }

// this protocol rule gets called when any denomination cell is selected nad returns all denominations but one with isSelected true
    func selectedDenominations(denominations: [Denomination]) {
        self.detailOfGiftVM.gift?.denominations = denominations
    }
    
// this protocol rule gets called when BuyNow button is tapped and screens moves to the GiftBought Screen
    func onTapBuyNow() {
        let giftBoughtVC = GiftBought()
        giftBoughtVC.gift = self.detailOfGiftVM.gift
        self.navigationController?.pushViewController(giftBoughtVC, animated: true)
    }

// this protocol rule gets called when AddToCart button is tapped. Also gift card gonna be added to userDefault
    func onTapAddToCart() {
        guard let gift = self.detailOfGiftVM.gift else {return}
        if self.detailOfGiftVM.addToCart(gift: gift) == false {
            let alert = UIAlertController.alert(message: AppConstants.strGiftAlreadyAdded) {}
            self.navigationController?.present(alert, animated: true)
        } else {
            let alert = UIAlertController.alert(title:AppConstants.strAdded, message: AppConstants.strGiftIsAdded) {
                self.navigationController?.popViewController(animated: true)
            }
            self.navigationController?.present(alert, animated: true, completion: nil)
        }
    }
}

