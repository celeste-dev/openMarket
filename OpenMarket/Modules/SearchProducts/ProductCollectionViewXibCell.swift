//
//  ProductCollectionViewXibCell.swift
//  OpenMarket
//
//  Created by Erika Russi on 2024-01-19.
//

import UIKit

class ProductCollectionViewXibCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUp(product: Result) {
        if let url = URL(string: product.thumbnail) {
            ImageUtil.downloadImage(from: url, uiImageView: self.productImage, width: 120, height: 120)
            self.setNeedsLayout()
        }
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 2
        titleLabel.attributedText = NSAttributedString(
            string: product.title,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold),
                NSAttributedString.Key.foregroundColor: UIColor.black])
        
        priceLabel.attributedText = NSAttributedString(
            string: CurrencyUtil.getCurrencyNumber(balance: String(product.price), fractionDigits: 2),
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular),
                NSAttributedString.Key.foregroundColor: UIColor.black])
        stockLabel.attributedText = NSAttributedString(
            string: String(product.availableQuantity) + " unit(s) available",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular),
                NSAttributedString.Key.foregroundColor: UIColor.black])
    }
    
    
}
