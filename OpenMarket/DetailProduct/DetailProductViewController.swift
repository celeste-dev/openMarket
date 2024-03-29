//
//  DetailProductViewController.swift
//  OpenMarket
//
//  Created by Erika Russi on 2024-01-19.
//

import UIKit

class DetailProductViewController: UIViewController {

    // - Internal properties -
    var selectedCountry: String? = ""
    var selectedProduct: Result? = nil
    
    // - IBOutlets -
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    
    // - LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        if selectedProduct != nil{
            self.setUp(detailProduct: selectedProduct!, countryKey: self.selectedCountry ?? "")
        }
    }
    
    // - Private Methods -
    private func setUp(detailProduct: Result, countryKey: String) {
        if let url = URL(string: detailProduct.thumbnail) {
            ImageUtil.downloadImage(from: url, uiImageView: self.productImage, width: 300, height: 300)
        }
        
        titleLabel.attributedText = NSAttributedString(
            string: detailProduct.title,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold),
                NSAttributedString.Key.foregroundColor: UIColor.black])
        statusLabel.attributedText = NSAttributedString(
            string: detailProduct.condition.capitalized,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold),
                NSAttributedString.Key.foregroundColor: UIColor.black])
        
        let productPrice: String = if countryKey == "MLB" {
            "R" + CurrencyUtil.getCurrencyNumber(balance: String(detailProduct.price), fractionDigits: 2)
        } else {
            CurrencyUtil.getCurrencyNumber(balance: String(detailProduct.price), fractionDigits: 2)
        }
        priceLabel.attributedText = NSAttributedString(
            string: productPrice,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular),
                NSAttributedString.Key.foregroundColor: UIColor.black])
        stockLabel.attributedText = NSAttributedString(
            string: String(detailProduct.availableQuantity) + " unit(s) available",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular),
                NSAttributedString.Key.foregroundColor: UIColor.black])
    }
}
