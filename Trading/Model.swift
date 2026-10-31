//
//  Model.swift
//  Trading
//
//  Created by Divya on 27/10/26.
//

struct Stock: Identifiable, Hashable {
    let id: Int
    let symbol: String
    let name: String
    let price: Double
    let changePercent: Double
    
    static let allStocks: [Stock] = [
        .init(id: 1, symbol: "AAPL", name: "Apple", price: 269.50, changePercent: 1.82),
        .init(id: 2, symbol: "MSFT", name: "Microsoft", price: 531.20, changePercent: 0.74),
        .init(id: 3, symbol: "NVDA", name: "NVIDIA", price: 185.40, changePercent: 3.25),
        .init(id: 4, symbol: "TSLA", name: "Tesla", price: 442.10, changePercent: -2.14),
        .init(id: 5, symbol: "AMZN", name: "Amazon", price: 225.80, changePercent: 1.15),
        .init(id: 6, symbol: "GOOGL", name: "Alphabet", price: 252.40, changePercent: -0.65),
        .init(id: 7, symbol: "META", name: "Meta Platforms", price: 735.60, changePercent: 2.08),
        .init(id: 8, symbol: "NFLX", name: "Netflix", price: 1_180.30, changePercent: -1.30),
        .init(id: 9, symbol: "AMD", name: "AMD", price: 162.80, changePercent: 0.95),
        .init(id: 10, symbol: "INTC", name: "Intel", price: 38.25, changePercent: -3.10),
        .init(id: 11, symbol: "ORCL", name: "Oracle", price: 245.10, changePercent: 1.42),
        .init(id: 12, symbol: "IBM", name: "IBM", price: 298.40, changePercent: 0.38),
        .init(id: 13, symbol: "UBER", name: "Uber", price: 96.70, changePercent: -0.82),
        .init(id: 14, symbol: "DIS", name: "Disney", price: 113.20, changePercent: 1.05),
        .init(id: 15, symbol: "JPM", name: "JPMorgan Chase", price: 302.60, changePercent: 0.62),
        .init(id: 16, symbol: "V", name: "Visa", price: 348.90, changePercent: 0.41),
        .init(id: 17, symbol: "KO", name: "Coca-Cola", price: 71.30, changePercent: -0.22),
        .init(id: 18, symbol: "WMT", name: "Walmart", price: 104.50, changePercent: 1.10),
        .init(id: 19, symbol: "COST", name: "Costco", price: 925.40, changePercent: 0.88),
        .init(id: 20, symbol: "BA", name: "Boeing", price: 213.70, changePercent: -1.76)

    ]
}

enum StockFilter: String, Identifiable, CaseIterable {
    case all = "All"
    case gainers = "Gainers"
    case losers = "Losers"
    
    var id: String { rawValue }
}
