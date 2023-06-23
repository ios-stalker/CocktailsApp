import Foundation
import RxSwift

protocol CocktailsViewModel: AnyObject {
    var cocktailsList: BehaviorSubject<CocktailsModel> { get set }
    var serviceManager: ServiceManager { get set }
    func fetchAlcoholCocktails()
}

class CocktailsViewModelImpl: CocktailsViewModel {
  
    var serviceManager: ServiceManager
    var cocktailsList: BehaviorSubject<CocktailsModel>
    
    func fetchAlcoholCocktails() {
        serviceManager.getCocktails(url: Constans().AlcoholicCocktailsURL) { [weak self] result in
            guard self != nil else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let cocktails):
                    print("\(cocktails)")
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
