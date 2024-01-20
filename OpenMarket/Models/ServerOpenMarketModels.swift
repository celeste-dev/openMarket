//
//  ServerOpenMarketModels.swift
//  OpenMarket
//
//  Created by Erika Russi on 2024-01-18.
//

import Foundation

struct ProductResearchResponse: Codable {
    
    let availableFilters: [AvailableFilter]
    let availableSorts: [AvailableSort]
    let countryDefaultTimeZone: String
    let paging: Paging
    let query: String
    let results: [Result]
    let siteId: String
    let sort: Sort
    
    private enum CodingKeys: String, CodingKey {
        case availableFilters = "available_filters"
        case availableSorts = "available_sorts"
        case countryDefaultTimeZone = "country_default_time_zone"
        case paging
        case query
        case results = "results"
        case siteId = "site_id"
        case sort
    }
}

struct AvailableFilter: Codable {
    let id: String
    let name: String
    let type: String
    let values: [Value]
}

struct AvailableSort : Codable {
    let id: String
    let name: String
}

struct Paging : Codable {
    let limit: Int
    let offset: Int
    let primaryResults: Int
    let total: Int
    
    private enum CodingKeys: String, CodingKey {
        case limit
        case offset
        case primaryResults = "primary_results"
        case total
    }
}

struct Result: Codable {
    let acceptsMercadopago: Bool
    let attributes: [Attribute]
    let availableQuantity: Int
    let buyingMode: String
    let catalogListing: Bool?
    let catalogProductId: String?
    let categoryId: String
    let condition: String
    let currencyId: String
    let differentialPricing: DifferentialPricing?
    let domainId: String
    let id: String
    let installments: Installments?
    let listingTypeId: String
    let orderBackend: Int
    let originalPrice: Double? = 0.0
    let permalink: String?
    let price: Double
    let seller: Seller
    let shipping: Shipping
    let siteId: String
    let soldQuantity: Int? = 0
    let stopTime: String
    let tags: [String]? = []
    let thumbnail: String
    let thumbnailId: String
    let title: String
    let useThumbnailId: Bool
    
    private enum CodingKeys: String, CodingKey {
        case acceptsMercadopago = "accepts_mercadopago"
        case attributes
        case availableQuantity = "available_quantity"
        case buyingMode = "buying_mode"
        case catalogListing = "catalog_listing"
        case catalogProductId = "catalog_product_id"
        case categoryId = "category_id"
        case condition
        case currencyId = "currency_id"
        case differentialPricing = "differential_pricing"
        case domainId = "domain_id"
        case id
        case installments
        case listingTypeId = "listing_type_id"
        case orderBackend = "order_backend"
        case originalPrice = "original_price"
        case permalink
        case price
        case seller
        case shipping
        case siteId = "site_id"
        case soldQuantity = "sold_quantity"
        case stopTime = "stop_time"
        case tags
        case thumbnail
        case thumbnailId = "thumbnail_id"
        case title
        case useThumbnailId = "use_thumbnail_id"
    }
}

struct Sort: Codable {
    let id: String
    let name: String
}

struct Value: Codable {
    let id: String
    let name: String
    let results: Int
}

struct Attribute: Codable {
    let attributeGroupId: String
    let attributeGroupName: String
    let id: String
    let name: String
    let source: Int64?
    let valueId: String?
    let valueName: String?
    
    private enum CodingKeys: String, CodingKey {
        case attributeGroupId = "attribute_group_id"
        case attributeGroupName = "attribute_group_name"
        case id
        case name
        case source
        case valueId = "value_id"
        case valueName = "value_name"
    }
}

struct DifferentialPricing: Codable  {
    let id: Int
}

struct Installments: Codable  {
    let amount: Double
    let currencyId: String
    let quantity: Int
    let rate: Double
    
    private enum CodingKeys: String, CodingKey {
        case amount
        case currencyId = "currency_id"
        case quantity
        case rate
    }
}

struct Seller: Codable {
    let id: Int
    let nickname: String?
}


struct Shipping: Codable {
    let freeShipping: Bool
    let logisticType: String?
    let mode: String
    let storePickUp: Bool
    let tags: [String]
    
    private enum CodingKeys: String, CodingKey {
        case freeShipping = "free_shipping"
        case logisticType = "logistic_type"
        case mode
        case storePickUp = "store_pick_up"
        case tags
    }
}


struct Presentation : Codable {
    let displayCurrency: String
    
    private enum CodingKeys: String, CodingKey {
        case displayCurrency = "display_currency"
    }
}
