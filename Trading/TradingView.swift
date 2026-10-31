//
//  TradingView.swift
//  Trading
//
//  Created by Divya on 27/10/26.
//

import SwiftUI

struct TradingView: View {
    
    @StateObject private var viewModel = TradingViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    portfolioView
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Market Watch")
                            .font(.title2.bold())
                        
                        Picker("Filter", selection: $viewModel.selectedFilter) {
                            ForEach(StockFilter.allCases) { filter in
                                Text(filter.rawValue).tag(filter)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        LazyVStack(spacing: 0) {
                            ForEach(viewModel.filteredStocks) { stock in
                                stockRow(stock: stock)
                                    .onAppear {
                                        if stock.id == viewModel.filteredStocks.last?.id {
                                            viewModel.loadNextPage()
                                        }
                                    }
                                Divider()
                            }
                            
                            if viewModel.isLoading {
                                ProgressView()
                                    .padding()
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("My Trading")
            .searchable(text: $viewModel.searchText, prompt: "Search Stocks")
            .onAppear {
                viewModel.loadInitialData()
            }
        }
    }
    
    var portfolioView: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Label("Portfolio Overview", systemImage: "chart.pie.fill")
                    .font(.headline)
                
                Spacer()
                
                Button {
                    viewModel.togglePorfolioVisibility()
                } label: {
                    Image(systemName: viewModel.isPortfolioVisible ?  "eye" : "eye.slash")
                }
                
            }
            
            Text("Total Portfolio Value")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Text(viewModel.isPortfolioVisible ? viewModel.portfolioValue.formatted(.currency(code: "USD")) : ".....")
                .font(.subheadline.bold())
            
            HStack() {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Invested")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Text(viewModel.isPortfolioVisible ? viewModel.investedAmount.formatted(.currency(code: "USD")) : ".....")
                        .font(.subheadline.bold())
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Total P/L")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Text(viewModel.isPortfolioVisible ? viewModel.profitLoss.formatted(.currency(code: "USD")) : ".....")
                        .font(.subheadline.bold())
                        .foregroundStyle(viewModel.profitLoss > 0 ? .green : .red)
                }
            }
        }
        .cardStyle()
    }
    
}

private func stockRow(stock: Stock) -> some View {
    HStack(spacing: 12) {
        VStack(alignment: .leading, spacing: 5) {
            Text(stock.symbol)
                .font(.headline)
            
            Text(stock.name)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        
        Spacer()
        
        VStack(alignment: .trailing, spacing: 5) {
            Text(stock.price, format: .currency(code: "USD"))
                .font(.subheadline.weight(.semibold))
            
            Text("\(stock.changePercent > 0 ? "+" : "")" + String(format: "%.2f%%", stock.changePercent))
                .font(.caption.bold())
                .foregroundStyle(stock.changePercent > 0 ? .green : .red)
        }
    }
    .padding()
    .contentShape(Rectangle())
}



#Preview {
    TradingView()
}
