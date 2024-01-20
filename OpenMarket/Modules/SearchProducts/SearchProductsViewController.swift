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
    
    // - LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("Selected country: \(selectedCountry)")
        searchProductsViewModel.selectedCountry = self.selectedCountry
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
        let nibName = UINib(nibName: "ProductCollectionViewXibCell", bundle: nil)
        self.productsCollectionView.register(nibName, forCellWithReuseIdentifier: "Cell")
        bindViewModel()
        productsSearchBar.delegate = self
    }
    
    // - Private Methods -
    private func bindViewModel(){
        searchProductsViewModel.uiStatus.bind { status in
            switch status {
            case .loading(let show):
                debugPrint("Loading: \(show)")
            case .error(let msg, let error):
                debugPrint("Error: \(msg), \(error?.localizedDescription ?? "")")
            case .successful(let value):
                self.productsCollectionView.reloadData()
                debugPrint("Successful")
//                debugPrint("Successful: \(value)")
//                debugPrint("Products: \(String(describing: value))")
            case .none:
                debugPrint("None")
            }
        }
    }
    
    // - Internal Methods -
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let searchDetailProduct = segue.destination as? DetailProductViewController {
            searchDetailProduct.selectedProduct = searchProductsViewModel.selectedProduct
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
            cell.setUp(product: result!)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProduct: Result? = self.searchProductsViewModel.products?.results[indexPath.row]
        debugPrint("selected product yeahh: \(selectedProduct)")
        self.searchProductsViewModel.selectedProduct = selectedProduct
        performSegue(withIdentifier: "DetailVC", sender: self)
    }
}

extension SearchProductsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searchProductsViewModel.products?.results = []
        debugPrint("search: \(searchText)")

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
