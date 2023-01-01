//
//  FilterService.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 31.12.22.
//
// MARK: Either use stringWithoutLineBreaks or disable line breaks in app
// MARK: Handle JSONDecoder error

import Foundation

struct FilterService {
    static let headers = [
        "X-RapidAPI-Key": "4a9d0bd286msh891ee756b7019a7p17bc6ajsn97ffd56d38bd",
        "X-RapidAPI-Host": "community-purgomalum.p.rapidapi.com"
    ]
    
    func filteredData(of string: String, completion: @escaping(String) -> Void){
//        let stringWithoutLineBreaks = string.replacingOccurrences(of: "\n", with: " ")
        let convertedString = string.replacingOccurrences(of: " ", with: "%20")
        
        guard let url = URL(string: "https://community-purgomalum.p.rapidapi.com/json?text=\(convertedString)") else { return print("Invalid URL") }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = FilterService.headers
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
//            guard response is HTTPURLResponse else { return print("Couldn't convert response")}
//            print(response as Any)
            
            if let data = data {
                if let decodedData = try? JSONDecoder().decode(Filter.self, from: data) {
                    let result = decodedData.result
                    completion(result)
                }
            }
        }
        
        dataTask.resume()
    }
}
