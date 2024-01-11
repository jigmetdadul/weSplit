//
//  ContentView.swift
//  WeSplit
//
//  Created by Jigmet stanzin Dadul on 05/01/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedCurr = "USD"
    @State private var chequeAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused: Bool
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)

        let tipValue = chequeAmount / 100 * tipSelection
        let grandTotal = chequeAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    private var localCurrency = Locale.current.currency?.identifier ?? "USD"
    private var tipPercentageList = [0, 10, 20, 25]
    private var Currency = ["USD", "Rupees", "Euro"]

    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("Enter the cheque details")){
                    TextField("Amount", value: $chequeAmount, format: .currency(code: localCurrency)).keyboardType(.decimalPad).focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                   
                }
                Section(header: Text("Tip percentage")) {
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(0..<101){
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section(header: Text("Cheque per person")){
                    Text(totalPerPerson, format: .currency(code: localCurrency))
                }
                Section(header: Text("Total Bill Details")){
                    Text(chequeAmount, format: .currency(code: localCurrency))
                    
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                if amountIsFocused {
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
