//
//  FindFalconModel.swift
//  FindingFalcon
//
//  Created by Pallab Maiti on 05/03/24.
//

import Foundation

enum FindingFalcon {
    enum LoadPlanets {
        struct Request { }
        
        struct Response: Codable, Hashable {
            let name: String
            let distance: Int
        }
        
        struct ViewModel { }
    }
    
    enum LoadVehicles {
        struct Request { }
        
        struct Response: Codable, Hashable {
            let name: String
            let totalNo: Int
            let maxDistance: Int
            let speed: Int
        }
        
        struct ViewModel { }
    }
    
    enum LoadPlanetsAndVehicles {
        struct Request { }
        
        struct Response: Equatable {
            let planets: [LoadPlanets.Response]
            let vehicles: [LoadVehicles.Response]
        }
        
        struct ViewModel {
            let vehicles: [Vehicle]
            let planets: [Planet]
        }
    }
    
    enum RetrieveToken {
        struct Request { }
        
        struct Response: Codable, Equatable {
            let token: String
        }
        
        struct ViewModel {
            let token: Token
        }
    }
}
