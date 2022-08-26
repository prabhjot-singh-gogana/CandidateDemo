# Mobile App Dev Guide

## Building


*I develop this **GiftCardTest** App in three screens.*

1. GiftsList - This screen shows the list of gift cards that got fetched from **GiftListVM** (ViewModel) class. Binds the reactive model (**Gift**) list with tableView which shows the 'gift card Image' and 'brand' of gift Card data. Tap on each card and navigates the screen to the detail screen i.e (**DetailOfGift**) includes with '**Gift**' model which has all the information about the card gift.


2. DetailOfGift - This screen has 5 views (mentioned below) each having different functionality. So there are 5 protocols that returns these 5 views and bind these views with table view section-header-view. 
    HeaderCardView - consists of Card Image, brand name and discount price.
    DenominationView - Consists of all denomination prices inthe  collection view.
    AddButtonView -Consists of two buttons one is "**Buy Now**" and other one is "**Add to Cart**". After pressing "**Buy Now**" button screen will navigate to **GiftIsBought** Screen with some gift details. After tapping on **"Add to Cart"** the gift will add to local storage. However, you cannot add the same gift card to the cart or to local storage. (Note - saved gifts logs can be seen on the first page after pressing on '**cart**' button) 
    ExtendedSectionView - Consist of "terms & condition" or disclaimerr". Tap on each element and  opens up the cell with their details.

3. GiftBought - Just a screen with gift card details that are bought. Press the "continue shopping" button to navigate to the root screen i.e GiftList Screen



## Testing

*Developed 3 unit test cases*
1. testResponseForGiftList - Test the GiftListVM requestGiftData method and also test the gift response. The expected gift should not be nil.
2. testAPIManagerClassWithJustResponse - Test the API manager by not using Gift **expected model** but any other model(**TestModel**)
  the expected result would bean  array of TestModel but with empty inside it which canbe testedt by toJSON method.
3. testToCheckGiftIsAlreadyExitInCart - the test case is used to check if the gift is already added or not. However, the could be scenarios with different denominations which is not done by me

## Additional Information

*Architecture MVC and MVVM are used*
1. GiftList -> MVVM
  - ViewModel (GiftListVM)
  - View (GiftListVC)
  - Model (Gift)

2. DetailOfGift -> MVC
  - View-Controller (DetailGiftVC)
  - Model (Gift)
/**Note I used ViewModel class but according to me it's not purely MVVM but its working is the same as MVC. Also used protocol-oriented programming in it. However, there are many ways to do it but just to show my some POP knowledge here/**
3. GiftIsBought -> MVC
  - View-Controller (GiftBought)
  - Model (Gift)


## Known issues
1. Did not show the 'detail' button in cards because I thought it looks better with the detail button however detail function can be used by simply clicking on a card.
2. "Add to card" won't let you add the same gift again. However, it should be added with different denominations. Not sure
3. Sometimes terms and condition and disclaimer does not work properly.
4. No Reachability checks.
5. In one function in DenominationView I used unnecessary BehaviorSubject just to bind the collection view items. however, we can use that some other way. I did that just to show binding with table functionality.
