//
//  SearchProductsViewModel.swift
//  OpenMarket
//
//  Created by Erika Russi on 2024-01-18.
//

import Foundation

class SearchProductsViewModel {
    
    var selectedCountry: String? = nil
    var errorMessage = ""
    var products: ProductResearchResponse? = nil
    var selectedProduct: Result? = nil
    
    var uiStatus: Observable<UIStatus<Any>> = Observable()
    
    init(selectedCountry: String? = nil) {
        self.selectedCountry = selectedCountry
    }
    
    func fetchProducts(productToSearch: String) {
        Task {
            self.uiStatus.value = .loading(true)
            if self.selectedCountry != nil {
                await MainActor.run {
                    self.errorMessage = ""
                }
                if let productsResearch = await NetworkAPI.getProducts(countryKey: self.selectedCountry!, productToSearch: productToSearch) {
                    await MainActor.run {
                        self.products = productsResearch
                        self.uiStatus.value = .loading(false)
                        self.uiStatus.value = .successful(productsResearch.results)
                    }
                } else {
                    await MainActor.run {
                        self.errorMessage = "Fetch data failed"
                        self.uiStatus.value = .error("Fetch data failed", NSError(domain: "ExampleDomain", code: 123, userInfo: nil))
                        self.uiStatus.value = .loading(false)

                    }
                }
            } else {
                self.errorMessage = "Invalid country"
                self.uiStatus.value = .error("Invalid country", NSError(domain: "ExampleDomain", code: 123, userInfo: nil))
                self.uiStatus.value = .loading(false)
            }
        }
    }
    
    func productQuantity() -> Int {
        return (self.products?.results ?? []).count
    }
}
