//
//  OnboardingViewController.swift
//  OpenMarket
//
//  Created by Erika Russi on 2024-01-14.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    // - Internal properties -
    let onboardingViewModel: OnboardingViewModel = OnboardingViewModel()
    
    // - IBOutlets -
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var countryPickerView: UIPickerView!

    // - LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
    }
    
    // - Private Methods -
    private func setUp() {
        contentView.backgroundColor = UIColor.yellow
        logoImage.image = UIImage(named: "shopping_car_icon")
    }
    
    // - Internal Methods -
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let searchProductDestination = segue.destination as? SearchProductsViewController {
            searchProductDestination.selectedCountry = onboardingViewModel.selectedCountry?.key ?? ""
        }
    }
}

extension OnboardingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return onboardingViewModel.getAvailableCountries().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return onboardingViewModel.getAvailableCountries()[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        onboardingViewModel.selectedCountry = onboardingViewModel.getAvailableCountries()[row]
        performSegue(withIdentifier: "SearchVC", sender: self)
    }
}
