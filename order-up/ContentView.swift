//
//  ContentView.swift
//  order-up
//
//  Created by YJ Soon on 14/8/26.
//

import SwiftUI

struct Order: Hashable {
    var milo = 0
    var teh = 0
    var toast = 0
}

struct HomeView: View {
    @State private var pastOrders: [Order] = []

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Order Up")
                    .font(.largeTitle)
                    .bold()

                NavigationLink {
                    ContentView(pastOrders: $pastOrders)
                } label: {
                    Text("Start Ordering")
                        .font(.title2)
                }

                NavigationLink {
                    PastOrdersView(orders: pastOrders)
                } label: {
                    Text("Past Orders")
                        .font(.title2)
                }
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
    }
}

struct PastOrdersView: View {
    let orders: [Order]

    var body: some View {
        VStack(spacing: 20) {
            ForEach(orders.suffix(2).reversed(), id: \.self) { order in
                VStack {
                    if order.milo > 0 {
                        Text("Milo x\(order.milo)")
                    }
                    if order.teh > 0 {
                        Text("Teh x\(order.teh)")
                    }
                    if order.toast > 0 {
                        Text("Kaya Toast x\(order.toast)")
                    }
                    Text("Total  $\(Double(order.milo) * 1.5 + Double(order.teh) * 1.2 + Double(order.toast) * 2.0, specifier: "%.2f")")
                        .bold()
                }
                .padding()
                .background(Color.gray.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
        .padding(20)
        .navigationTitle("Past Orders")
    }
}

struct ContentView: View {
    @State private var milo = 0
    @State private var teh = 0
    @State private var toast = 0
    @State private var flag = false
    @State private var tmp = 0
    @State private var arr: [String] = []

    @Binding var pastOrders: [Order]

    var body: some View {
        VStack(spacing: 20) {
            Text("Order Up")
                .font(.largeTitle)
                .bold()

            Text("Kopitiam snacks. Tap + to add.")
                .font(.title3)
                .foregroundStyle(.secondary)

            HStack {
                Text("🥤  Milo")
                    .font(.title2)
                Text("$1.50")
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(milo)")
                    .font(.title)
                    .monospacedDigit()
                Button {
                    if milo > 0 {
                        milo -= 1
                    }
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.largeTitle)
                }
                Button {
                    milo += 1
                    tmp = 1
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                }
            }
            .padding()
            .background(Color.orange.opacity(0.18))
            .clipShape(RoundedRectangle(cornerRadius: 16))

            HStack {
                Text("🍵  Teh")
                    .font(.title2)
                Text("$1.20")
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(teh)")
                    .font(.title)
                    .monospacedDigit()
                Button {
                    if teh > 0 {
                        teh -= 1
                    }
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.largeTitle)
                }
                Button {
                    teh += 1
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                }
            }
            .padding()
            .background(Color.brown.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 16))

            HStack {
                Text("🍞  Kaya Toast")
                    .font(.title2)
                Text("$2.00")
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(toast)")
                    .font(.title)
                    .monospacedDigit()
                Button {
                    if toast > 0 {
                        toast -= 1
                    }
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.largeTitle)
                }
                Button {
                    toast += 1
                    arr.append("x")
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                }
            }
            .padding()
            .background(Color.yellow.opacity(0.22))
            .clipShape(RoundedRectangle(cornerRadius: 16))

            Text("Total  $\(Double(milo) * 1.5 + Double(teh) * 1.2 + Double(toast) * 2.0, specifier: "%.2f")")
                .font(.title)
                .bold()
                .padding(.top, 8)

            Button("Place Order") {
                pastOrders.append(Order(milo: milo, teh: teh, toast: toast))
                flag = true
                milo = 0
                teh = 0
                toast = 0
                Task {
                    try? await Task.sleep(for: .seconds(1))
                    flag = false
                }
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .font(.title2)
            .disabled(milo == 0 && teh == 0 && toast == 0)
        }
        .padding(20)
        .sheet(isPresented: $flag) {
            VStack {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 100))
                    .foregroundStyle(.green)
                Text("Order Completed")
                    .font(.largeTitle)
                    .bold()
            }
            .presentationDetents([.medium])
        }
    }
}

#Preview {
    ContentView(pastOrders: .constant([]))
}

#Preview {
    HomeView()
}
