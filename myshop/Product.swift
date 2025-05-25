import Foundation

struct Product: Decodable {
    let product_id: String
    let name: String
    let brand: String
    let model: String
    let specs: String
    let price: String
    let warranty_period: String
    let image_url: String
}

