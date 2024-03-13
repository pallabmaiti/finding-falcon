//
//  DestinationView.swift
//  FindingFalcon
//
//  Created by Pallab Maiti on 05/03/24.
//

import SwiftUI
import Combine

struct DestinationView: View {
    var destination: Destination
    var updatedVehicleList: ([Vehicle]) -> Void
    var updatedPlanetList: ([Planet]) -> Void

    @State private var isSelected = false
    

    var body: some View {
        VStack() {
            HStack() {
                Text(destination.name)
                Spacer()
                Text(destination.selectedPlanet?.name ?? "Select")
                    .frame(maxWidth: .infinity, alignment: .trailing)
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
                    ForEach(destination.planetList, id: \.self) { item in
                        Text(item.name)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .onTapGesture {
                                updatePlanetList(item)
                            }
                        Divider()
                    }
                }
            }
            if destination.selectedPlanet != nil {
                ForEach(destination.vehicleList, id: \.self) {
                    SelectVehicleView(vehicle: $0, onSelectVehicle: updateVehicleList)
                }
            }
        }
    }
    
    private func updateVehicleList(_ vehicle: Vehicle) {
        if !vehicle.selected, vehicle.totalNo == 0 {
            return
        }
        guard let sP = destination.selectedPlanet, sP.distance <= vehicle.maxDistance else {
            return
        }
        if let selectedVehicle = destination.selectedVehicle, selectedVehicle.name == vehicle.name {
            return
        }
        let list = destination.vehicleList.map({ item in
            var v = item
            if let sV = destination.selectedVehicle, item.name == sV.name {
                v = sV
            } else {
                v.selected = (item.name == vehicle.name && item.totalNo > 0)
                v.totalNo = (item.name == vehicle.name && item.totalNo > 0) ? (v.totalNo - 1) : v.totalNo
            }
            return v
        })
        destination.vehicleList = list
        destination.selectedVehicle = vehicle
        updatedVehicleList(list)
    }
    
    private func updatePlanetList(_ planet: Planet) {
        let list = destination.planetList.map { item in
            var p = item
            p.selected = item.name == planet.name
            return p
        }
        destination.selectedPlanet = planet
        isSelected = false
        updatedPlanetList(list)
    }
    
    private func onButtonSelect() {
        isSelected = !isSelected
    }
}
