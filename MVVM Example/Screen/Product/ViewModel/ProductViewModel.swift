//
//  ProductViewModel.swift
//  MVVM Example
//
//  Created by Admin on 16/01/23.
//

import Foundation

final class ProductViewModel {
    
    var product:[Product] = []
    var eventHandler: ((_ event: Event) -> Void)? //Data binding closure
    
    func fetchProduct() {
        self.eventHandler?(.loading)
        APIManager.shared.fetchProduct { result in
            self.eventHandler?(.stopLoading)
            switch result {
            case .success(let product):
                self.product = product
                self.eventHandler?(.dataLoading)
                print("success")
            case .failure(let error):
                self.eventHandler?(.error(error))
                
            }
        }
    }
}

//data Binding

extension ProductViewModel {
    
    enum Event {
        case loading
        case stopLoading
        case dataLoading
        case error(Error?)
    }
}
