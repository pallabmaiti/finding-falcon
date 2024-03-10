//
//  DestinationView.swift
//  FindingFalcon
//
//  Created by Pallab Maiti on 05/03/24.
//

import SwiftUI
import Combine

struct DestinationView: View {
    var name: String
    
    @Binding var planetList: [Planet]
    @Binding var vehicleList: [Vehicle]
    @Binding var selectedVehicle: Vehicle?
    @Binding var selectedPlanet: Planet?
    var vehicleListPassthroughSubject = PassthroughSubject<[Vehicle], Never>()
    var planetListPassthroughSubject = PassthroughSubject<[Planet], Never>()

    @State private var isSelected = false
    

    var body: some View {
        VStack() {
            HStack() {
                Text(name)
                Spacer()
                Text(selectedPlanet?.name ?? "Select")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                /*TextField("Select", text: $searchedText)
                    .multilineTextAlignment(.trailing)
                    .onChange(of: searchedText, initial: true, { old, new  in
                        onTextChange(character: new)
                    })*/
                Spacer()
                Button(action:{
                    onButtonSelect()
                }) {
                    HStack(alignment: .center, spacing: 10) {
                        Image(systemName: isSelected ? "chevron.up" : "chevron.down")
                    }
                }
                .buttonStyle(.borderless)
            }
            .frame(height: 50)
            if isSelected {
                List {
                    Divider()
                    ForEach(planetList, id: \.self) { item in
                        Text(item.name)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .onTapGesture {
                                updatePlanetList(item)
                            }
                        Divider()
                    }
                }
            }
            if selectedPlanet != nil {
                ForEach(vehicleList, id: \.self) {
                    SelectVehicleView(vehicle: $0, onSelectVehicle: updateVehicleList)
                }
            }
        }
    }
    
    private func updateVehicleList(_ vehicle: Vehicle) {
        guard let sP = selectedPlanet, sP.distance <= vehicle.maxDistance else {
            return
        }
        if let selectedVehicle = selectedVehicle, selectedVehicle.name == vehicle.name {
            return
        }
        let list = vehicleList.map({ item in
            var v = item
            if let sV = selectedVehicle, item.name == sV.name {
                v = sV
            } else {
                v.selected = (item.name == vehicle.name && item.totalNo > 0)
                v.totalNo = (item.name == vehicle.name && item.totalNo > 0) ? (v.totalNo - 1) : v.totalNo
            }
            return v
        })
        vehicleList = list
        vehicleListPassthroughSubject.send(list)
        selectedVehicle = vehicle
    }
    
    private func updatePlanetList(_ planet: Planet) {
        let list = planetList.map { item in
            var p = item
            p.selected = item.name == planet.name
            return p
        }
        planetListPassthroughSubject.send(list)
        selectedPlanet = planet
        isSelected = false
    }
    
    private func onButtonSelect() {
        isSelected = !isSelected
    }
    
    /*func onTextChange(character: String) {
        if character == "" {
            
        } else {
            
        }
    }*/
}
