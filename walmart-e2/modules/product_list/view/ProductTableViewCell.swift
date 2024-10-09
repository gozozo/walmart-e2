//
//  ProductTableViewCell.swift
//  walmart-e2
//
//  Created by Luis Enrique Vazquez Escobar on 08/10/24.
//

import UIKit

/// A custom table view cell used to display product information in a list.
/// This cell is part of the product list module.
/// 
/// - Note: Ensure that this cell is registered with the table view before use.
class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productCategoryLabel: UILabel!
    @IBOutlet private weak var productPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
    }
    
    /// Configures the cell with the provided product information.
    ///
    /// - Parameter product: The `Product` object containing the details to be displayed in the cell.
    func configure(with product: Product) {
        productNameLabel.text = product.title
        productCategoryLabel.text = product.category
        productPriceLabel.text = "$\(product.price)"
        guard let url = URL(string: product.image) else { return }
        UIImage.from(url: url ) {  image in
            DispatchQueue.main.async {
                self.productImageView.image = image
            }
        }
    }
}


/// An extension of the `UIImage` class to add custom functionality or properties
/// specific to the Walmart product list module.
extension UIImage {
    static func from(url: URL, completion: @escaping (UIImage?) -> Void) {
        // Create a URL session
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Check for errors and valid data
            if let data = data, error == nil {
                // Create an image from the data
                let image = UIImage(data: data)
                completion(image)
            } else {
                // Return nil if there was an error
                completion(nil)
            }
        }
        // Start the task
        task.resume()
    }
}
