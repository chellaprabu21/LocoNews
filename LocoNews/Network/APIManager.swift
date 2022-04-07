//
//  APIManager.swift
//  LocoNews
//
//  Created by Chellaprabu V on 06/04/22.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
        
    let urlSession = URLSession.shared
    let baseUrl = "https://newsapi.org/v2/"
    public let apiKey = "470dcd0ceba74720b303a7ec244fdbd3"
    
    func getNews(forPage page:Int = 1,forCountry country: String?, _ completion: @escaping ([Article]) -> Void){
        let request = getRequest(.headlines(page: page, country: country))
        
        let task = urlSession.dataTask(with: request) { data, response, error in
            
            do{
            let jsonObject = try JSONSerialization.jsonObject(with: data!)
            }
            catch{
                
            }
            
            guard let safeData = data else { return }
            
            do{
            let result = try JSONDecoder().decode(News.self, from: safeData)
                print(result)
                completion(result.articles)
            }
            catch{
                
            }
            
        }
        
        task.resume()
    }
}


// MARK: - Request Contruction

extension APIManager{
    
    enum APIParams{
        case headlines(page: Int, country: String?)
        case everything
        case source
        
        func getPath() -> String{
            switch self{
            case .headlines:
                return "top-headlines"
            case .everything:
                return "everything"
            case .source:
                return "sources"
            }
        }
        
        func getParam() -> [String:String]{
            switch self {
            case .headlines(let page, let country):
                return ["country": country ?? "in",
                        "page": "\(page)"]
            case .everything:
                return ["q" : "test"]
                
            case .source:
                return ["country": "in",
                        "pageSize": "10"]
            }
        }
        
        func paramsToString() -> String {
            var parameterArray = getParam().map{ key, value in
                return "\(key)=\(value)"
            }
            parameterArray.append("apiKey=470dcd0ceba74720b303a7ec244fdbd3")
            return parameterArray.joined(separator: "&")
        }
    }
    

    private func getRequest(_ params: APIParams) -> URLRequest{
        
        let path = params.getPath()
        let stringParams = params.paramsToString()
        let fullURL = URL(string: self.baseUrl.appending("\(path)?\(stringParams)"))
        var request = URLRequest(url: fullURL!)
        request.httpMethod = "GET"
        return request
    }
}
