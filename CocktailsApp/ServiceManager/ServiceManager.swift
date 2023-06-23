import Foundation
import RxSwift

protocol ServiceManager {
    func getCocktails(url: String, completion: @escaping (Result<CocktailsModel, Error>) -> Void)
}

class ServiceManagerImpl: ServiceManager {
    
    func getCocktails(url: String, completion: @escaping (Result<CocktailsModel, Error>) -> Void) {
        guard let urlString = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: urlString) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let decoder = JSONDecoder()
                guard let data = data else { return }
                let response = try decoder.decode(CocktailsModel.self, from: data)
                print(response)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
