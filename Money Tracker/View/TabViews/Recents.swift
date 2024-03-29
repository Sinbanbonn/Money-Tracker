//
//  Recents.swift
//  Money Tracker
//
//  Created by Андрей Логвинов on 1/18/24.
//

import SwiftUI
import SwiftData

struct Recents: View {
    // MARK: - User Properties
    @AppStorage("userName") private var userName: String = ""
    
    // MARK: -  View Properties
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.endOfMonth
    @State private var showFilterView: Bool = false
    @State private var selectedCateory: Category = .expense
    
    // MARK: - Animation Properties
    @Namespace private var animation
    @Query(sort: [SortDescriptor(\Transaction.dateAdded, order: .reverse)], animation: .snappy) private var transactions: [Transaction]
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            NavigationStack {
                ScrollView(.vertical) {
                    LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                        Section {
                            Button {
                                showFilterView = true
                            } label: {
                                Text("\(format(date: startDate, format: "dd -- MMM yy")) to \(format(date: endDate, format: "dd -- MMM yy"))")
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                            }
                            .hSpacing(.leading)
                            
                            FilterTransactionsView(startDate: startDate, endDate: endDate) { transaction in
                                /// Card View
                                CardView(income: total(transactions, category: .income), expense: total(transactions, category: .expense))
                                
                                /// Custom Segmented Control
                                CustomSegmentedControl()
                                    .padding(.bottom, 10)
                                
                                ForEach(transactions.filter({ $0.category == selectedCateory.rawValue })) { transaction in
                                    NavigationLink(value: transaction) {
                                        TransactionCardView(transaction: transaction)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        } header: {
                            headerView(size)
                        }
                    }
                    .padding(15)
                }
                .background(.gray.opacity(0.15))
                .blur(radius: showFilterView ? 5 : 0)
                .disabled(showFilterView)
                .navigationDestination(for: Transaction.self) { transaction in
                    TransactionView(editTransaction: transaction)
                }
            }
            .overlay {
                if showFilterView {
                    DateFilterView(start: startDate, end: endDate, onSubmit: {
                        start, end in
                        startDate = start
                        endDate = end
                        showFilterView = false
                    }, onClose: {
                        showFilterView = false
                    })
                    .transition(.move(edge: .leading))
                }
            }
            .animation(.snappy, value: showFilterView)
        }
    }
    
    @ViewBuilder
    func headerView(_ size: CGSize) -> some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 5){
                Text("Welcome!")
                    .font(.title.bold())
                
                if !userName.isEmpty {
                    Text(userName)
                        .font(.callout)
                        .foregroundStyle(.gray)
                }
            }
            .visualEffect { content, geometryProxy in
                content
                    .scaleEffect(headerScale(size, proxy: geometryProxy), anchor: .topLeading)
            }
            
            Spacer(minLength: 0)
            
            NavigationLink {
                TransactionView()
            } label: {
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 45, height: 45)
                    .background(appTint.gradient, in: .circle)
                    .contentShape(.circle)
            }
        }
        .padding(.bottom, userName.isEmpty ? 10 : 5)
        .background {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(.ultraThinMaterial)
                
                Divider()
                
            }
            .visualEffect { content, geometryProxy in
                content
                    .opacity(headerBGOpacity(geometryProxy))
            }
            .padding(.horizontal, -15)
            .padding(.top, -(safeArea.top + 15))
        }
        
    }
    
    /// Segmented Control
    @ViewBuilder
    func CustomSegmentedControl() -> some View {
        HStack(spacing: 0) {
            ForEach(Category.allCases, id: \.rawValue) { category in
                Text(category.rawValue)
                    .hSpacing()
                    .padding(.vertical, 10)
                    .background {
                        if category == selectedCateory{
                            Capsule()
                                .fill(.background)
                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                        }
                    }
                    .contentShape(.capsule)
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selectedCateory = category
                        }
                    }
            }
        }
        .background(.gray.opacity(0.15), in: .capsule)
        .padding(.top, 5)
    }
    
    func headerBGOpacity(_ proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY + safeArea.top
        return minY > 0 ? 0 : (-minY / 15)
    }
    
    func headerScale(_ size: CGSize, proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY
        let screenHeight = size.height
        
        let progress = minY / screenHeight
        let scale = (min(max(progress, 0), 1)) * 0.6
        
        return 1 + scale
    }
    
    
}

#Preview {
    ContentView()
}
