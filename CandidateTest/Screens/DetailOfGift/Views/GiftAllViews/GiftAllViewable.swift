//
//  GiftAllViewable.swift
//  CandidateTest
//
//  Created by Prabhjot Singh Gogana on 26/8/2022.
//


// ----------- GiftHeaderViewble - which created the view for Header Card View----------//
protocol GiftHeaderViewble {}

extension GiftHeaderViewble {
    func headerView(gift: Gift) -> HeaderCardView {
        let headerView = HeaderCardView(frame: .zero)
        headerView.gift = gift
        return headerView
    }
}

// ----------- DenominationViewable - which created the view for Denomination Collection View----------//

protocol DenominationViewable {
    func selectedDenominations(denominations: [Denomination])
}

extension DenominationViewable {
    func denominationView(denominations: [Denomination]) -> DenominationView {
        let denominationView = DenominationView(frame: .zero)
        denominationView.setDenominations(denominations) { denominations in
            selectedDenominations(denominations: denominations)
        }
        return denominationView
    }
}

// ----------- AddButtonViewable - which created the view for two buttons ----------//

protocol AddButtonViewable {
    func onTapBuyNow()
    func onTapAddToCart()
}

extension AddButtonViewable {
    func buttonsView() -> AddButtonView {
        let buttonsView = AddButtonView(frame: .zero)
        buttonsView.onTapBuyNow = {
            onTapBuyNow()
        }
        buttonsView.onTapAddToCart = {
            onTapAddToCart()
        }
        return buttonsView
    }
}

// ----------- ExtendedSectionViewable - which creates the view for ExtendedSectionView ----------//

protocol ExtendedSectionViewable {
}

extension ExtendedSectionViewable {
    func extendedView(title: String) -> ExtendedSectionView {
        let extendedView = ExtendedSectionView(reuseIdentifier: title)
        extendedView.title = title
        return extendedView
    }

}

// Disclaimer Protocol which conforms the protocol ExtendedSectionViewable
protocol DisclaimerSectionViewbale: ExtendedSectionViewable {
    func onDisclaimerTap()
}

extension DisclaimerSectionViewbale {
    func disclaimerSectionViewbale(title: String) -> ExtendedSectionView {
        let view =  extendedView(title: title)
        view.handlerOnTap = {
            onDisclaimerTap()
        }
        return view
    }
}

// Terms Protocol which conforms the protocol ExtendedSectionViewable
protocol TermsSectionViewbale: ExtendedSectionViewable {
    func onTermsTap()
}

extension TermsSectionViewbale {
    func termsAndConditionSectionViewbale(title: String) -> ExtendedSectionView {
        let view = extendedView(title: title)
        view.handlerOnTap = {
            onTermsTap()
        }
        return view
    }

}
