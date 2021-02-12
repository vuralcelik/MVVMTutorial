//
//  CatsVM.swift
//  MVVMTutorial
//
//  Created by Vural Çelik on 12.02.2021.
//

import Foundation
import Alamofire

enum DogErrorTypes: String {
    case error = "Error!"
    case cantFetchMore = "You can't fetch more than 10 dog!"
}

class DogVM {
    //MARK: - Properties
    var response: DogModel?
    var fetchCount = 0
 
    //MARK: - Requests
    func getDogs(success: @escaping (DogModel?) -> Void,
                 failure: @escaping (DogErrorTypes?) -> Void) {
        if calculateFetchCountStatus() {
            AF.request("https://dog.ceo/api/breeds/image/random").responseDecodable { [weak self] (response: DataResponse<DogModel, AFError>) in
                switch response.result {
                case .success(let data):
                    self?.response = data
                    success(data)
                case .failure:
                    failure(.error)
                }
                self?.fetchCount += 1
            }
        }
        else {
            failure(.cantFetchMore)
        }

    }
    
    //MARK: - Helper Methods
    private func calculateFetchCountStatus() -> Bool {
        if fetchCount > 10 {
            return false
        }
        return true
    }
}
