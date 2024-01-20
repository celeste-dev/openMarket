//
//  DetailProductViewController.swift
//  OpenMarket
//
//  Created by Erika Russi on 2024-01-19.
//

import UIKit

class DetailProductViewController: UIViewController {

    // - Internal properties -
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
            self.setUp(detailProduct: selectedProduct!)
        }
    }
    
    // - Private Methods -
    private func setUp(detailProduct: Result) {
        titleLabel.attributedText = NSAttributedString(
            string: detailProduct.title,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold),
                NSAttributedString.Key.foregroundColor: UIColor.black])
        statusLabel.attributedText = NSAttributedString(
            string: detailProduct.condition,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold),
                NSAttributedString.Key.foregroundColor: UIColor.black])
        priceLabel.attributedText = NSAttributedString(
            string: "$" + String(detailProduct.price),
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
