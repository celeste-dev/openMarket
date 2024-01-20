//
//  ProductCollectionViewXibCell.swift
//  OpenMarket
//
//  Created by Cristhian Tolosa on 2024-01-19.
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
            downloadImage(from: url)
        }
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 2
        titleLabel.attributedText = NSAttributedString(
            string: product.title,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold),
                NSAttributedString.Key.foregroundColor: UIColor.black])
        priceLabel.attributedText = NSAttributedString(
            string: "$" + String(product.price),
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular),
                NSAttributedString.Key.foregroundColor: UIColor.black])
        stockLabel.attributedText = NSAttributedString(
            string: String(product.availableQuantity) + " unit(s) available",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular),
                NSAttributedString.Key.foregroundColor: UIColor.black])
    }
    
    func downloadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                let resizedImage = self.resizeImage(image, targetSize: CGSize(width: 120, height: 120))
                DispatchQueue.main.async {
                    self.productImage.image = resizedImage
                }
            }
        }.resume()
    }
    
    func resizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        let newSize: CGSize
        
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        return newImage ?? UIImage()
    }
}
