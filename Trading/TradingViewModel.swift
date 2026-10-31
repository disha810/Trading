//
//  TradingViewModel.swift
//  Trading
//
//  Created by Divya on 27/10/26.
//

import Foundation
import Combine

@MainActor
final class TradingViewModel: ObservableObject {
    @Published private(set) var stocks: [Stock] = []
    @Published private(set) var isLoading = false
    @Published var searchText = ""
    @Published var selectedFilter: StockFilter = .all
    
    @Published var isPortfolioVisible = false
    @Published var portfolioValue = 125_879
    @Published var investedAmount = 100_000
    
    private var currentPage = 0
    private let pageSize = 5
    
    private var cancellables = Set<AnyCancellable>()
    
    private let allStocks: [Stock] = [
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
    
    var profitLoss: Double {
        Double(portfolioValue - investedAmount)
    }
    
    var filteredStocks: [Stock] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return stocks.filter { stock in
            let matchesSearch = query.isEmpty || stock.symbol.localizedCaseInsensitiveContains(query) || stock.name.localizedCaseInsensitiveContains(query)
            
            var matchesFilter = false
            
            switch selectedFilter {
            case .all:
                matchesFilter = true
            case .gainers:
                matchesFilter = stock.changePercent > 0
            case .losers:
                matchesFilter = stock.changePercent < 0
            }
            
            return matchesSearch && matchesFilter
        }
    }
    
    func togglePorfolioVisibility() {
        isPortfolioVisible.toggle()
    }
    
    func loadInitialData() {
        guard filteredStocks.isEmpty else { return }
        loadNextPage()
    }
    
    func loadNextPage() {
        guard !isLoading else { return }
        
        let startIndex = currentPage * pageSize
        
        guard startIndex < allStocks.count else { return }
        
        isLoading = true
        
        let endIndex = min(startIndex + pageSize, allStocks.count)
        
        let pageData = allStocks[startIndex..<endIndex]
        
        Just(pageData)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newStocks in
                guard let self else { return }
                
                self.stocks.append(contentsOf: newStocks)
                self.isLoading = false
                self.currentPage += 1
            }
            .store(in: &cancellables)
    }
}
