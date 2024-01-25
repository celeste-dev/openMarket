//
//  SearchProductsViewController.swift
//  OpenMarket
//
//  Created by Erika Russi on 2024-01-16.
//

import UIKit

class SearchProductsViewController: UIViewController {
    
    // - Internal properties -
    var selectedCountry: String = ""
    let searchProductsViewModel: SearchProductsViewModel = SearchProductsViewModel()
    
    // - IBOutlets -
    @IBOutlet weak var productsSearchBar: UISearchBar!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var newSearchLabel: UILabel!
    
    // - LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("Selected country: \(selectedCountry)")
        self.activityIndicator.stopAnimating()
        searchProductsViewModel.selectedCountry = self.selectedCountry
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
        let nibName = UINib(nibName: "ProductCollectionViewXibCell", bundle: nil)
        self.productsCollectionView.register(nibName, forCellWithReuseIdentifier: "Cell")
        bindViewModel()
        productsSearchBar.delegate = self
        self.updateView()
    }
    
    // - Private Methods -
    private func bindViewModel(){
        searchProductsViewModel.uiStatus.bind { status in
            switch status {
            case .loading(let show):
                debugPrint("Loading: \(show)")
                if show {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            case .error(let msg, let error):
                debugPrint("Error: \(msg), \(error?.localizedDescription ?? "")")
                self.activityIndicator.stopAnimating()
            case .successful(let value):
                self.productsCollectionView.reloadData()
                self.productsCollectionView.setNeedsLayout()
                self.productsCollectionView.layoutIfNeeded()
                self.activityIndicator.stopAnimating()
                self.updateView()
                debugPrint("Successful: \((value as! Result).title)")
            case .none:
                debugPrint("None")
            }
        }
    }
    
    private func updateView() {
        if self.searchProductsViewModel.productQuantity() == 0 {
            self.newSearchLabel.attributedText = NSAttributedString(
                string: "Enter a New Search",
                attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold),
                    NSAttributedString.Key.foregroundColor: UIColor.gray])
            self.productsCollectionView.isHidden = true
        } else {
            self.newSearchLabel.isHidden = true
            self.productsCollectionView.isHidden = false
        }
    }
    
    // - Internal Methods -
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let searchDetailProduct = segue.destination as? DetailProductViewController {
            searchDetailProduct.selectedProduct = searchProductsViewModel.selectedProduct
            searchDetailProduct.selectedCountry = searchProductsViewModel.selectedCountry
        }
    }
}

extension SearchProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.searchProductsViewModel.products?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.productsCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ProductCollectionViewXibCell
        else {
            fatalError("Unable to dequeue ProductsCell")
        }
        let result: Result? = self.searchProductsViewModel.products?.results[indexPath.row]
        if result != nil {
            cell.setUp(product: result!, countryKey: self.selectedCountry)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProduct: Result? = self.searchProductsViewModel.products?.results[indexPath.row]
        let selectedCountry: String = self.selectedCountry
        self.searchProductsViewModel.selectedProduct = selectedProduct
        self.searchProductsViewModel.selectedCountry = selectedCountry
        performSegue(withIdentifier: "DetailVC", sender: self)
    }
}

extension SearchProductsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        debugPrint("Word to search: \(searchText)")
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.productsSearchBar.endEditing(true)
        if let searchText = searchBar.text {
            debugPrint("Search button clicked with text: \(searchText)")
            searchProductsViewModel.fetchProducts(productToSearch: searchText)
        } else {
            debugPrint("Search bar text is nil")
        }
    }
}
