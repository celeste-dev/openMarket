//
//  OnboardingViewModel.swift
//  OpenMarket
//
//  Created by Erika Russi on 2024-01-17.
//

import Foundation

class OnboardingViewModel {
    
    var selectedCountry: OnboardingCountry? = nil
    
    func getAvailableCountries() -> [OnboardingCountry] {
        var availableCountries: [OnboardingCountry] = []
        let argentina: OnboardingCountry = OnboardingCountry(name: "Argentina", key: "MLA")
        let brasil: OnboardingCountry = OnboardingCountry(name: "Brasil", key: "MLB")
        let mexico: OnboardingCountry = OnboardingCountry(name: "México", key: "MLM")
        let chile: OnboardingCountry = OnboardingCountry(name: "Chile", key: "MLC")
        let peru: OnboardingCountry = OnboardingCountry(name: "Perú", key: "MPE")
        let colombia: OnboardingCountry = OnboardingCountry(name: "Colombia", key: "MCO")
        
        availableCountries.append(argentina)
        availableCountries.append(brasil)
        availableCountries.append(mexico)
        availableCountries.append(chile)
        availableCountries.append(peru)
        availableCountries.append(colombia)
        
        return availableCountries
    }
}
