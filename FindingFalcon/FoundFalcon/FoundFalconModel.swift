//
//  FoundFalconModel.swift
//  FindingFalcon
//
//  Created by Pallab Maiti on 10/03/24.
//

import Foundation

enum FoundFalcon {
    enum Find {
        struct Request: Codable {
            let token: String
            let planetNames: [String]
            let vehicleNames: [String]
        }
        
        struct Response: Codable {
            let planetName: String?
            let status: String
        }
        
        struct ViewModelSuccess {
            let planetName: String?
        }
        
        struct ViewModelFailure { }
    }
    
    enum TotalTimeTaken {
        struct Request { }
        
        struct Response {
            let totalTimeTaken: Int
        }
        
        struct ViewModel {
            let totalTimeTaken: Int
        }
    }
}
