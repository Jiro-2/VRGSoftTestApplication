import Foundation
import Alamofire

public enum NewsCategory: String {
    
    case emailed, viewed, shared
}

public enum Period: Int {
    case day = 1, week = 7, month = 30
}



protocol NetworkManagerProtocol {
    
    func getNews(in category: NewsCategory, over period: Period, completion: @escaping ((_ responseData: NewsResponse?) -> ()))
}



final class NetworkManager: NetworkManagerProtocol {
    
    private let apiKey = "oQgEDKZpX6dSHYXNKLAGvjHrLIynJdP2"
    
    
    func getNews(in category: NewsCategory, over period: Period, completion: @escaping ((_ responseData: NewsResponse?) -> ())) {
        
        let request = AF.request("https://api.nytimes.com/svc/mostpopular/v2/\(category.rawValue)/\(period.rawValue).json?api-key=" + apiKey)
        
        request.responseDecodable(of: NewsResponse.self) { response in
            
            if let error = response.error {
                print("ERROR: \(error.localizedDescription)")
            }
            
            completion(response.value)
        }
    }
}
