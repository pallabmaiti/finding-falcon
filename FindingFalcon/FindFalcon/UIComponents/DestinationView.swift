//
//  DestinationView.swift
//  FindingFalcon
//
//  Created by Pallab Maiti on 05/03/24.
//

import SwiftUI
import Combine

struct DestinationView: View {
    @ObservedObject var destination: Destination
    var onVehicleSelect: (() -> Void)?
    var onPlanetSelect: (() -> Void)?

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
                    SelectVehicleView(vehicle: $0, selectedVehicle: destination.selectedVehicle, onSelectVehicle: updateVehicleList)
                }
            }
        }
    }
    
    private func updateVehicleList(_ vehicle: Vehicle) {
        // if vehicle is not available, return from here.
        guard vehicle.totalNo > 0 else {
            return
        }
        // if vehicle's max distance is less than the selected planet distance, return from here.
        guard let selectedPlanet = destination.selectedPlanet, selectedPlanet.distance <= vehicle.maxDistance else {
            return
        }
        // if vehicle is selected already, return from here.
        if let selectedVehicle = destination.selectedVehicle, selectedVehicle.name == vehicle.name {
            return
        }
        destination.selectedVehicle = vehicle
        onVehicleSelect?()
    }
    
    private func updatePlanetList(_ planet: Planet) {
        destination.selectedPlanet = planet
        isSelected = false
        onPlanetSelect?()
    }
    
    private func onButtonSelect() {
        isSelected = !isSelected
    }
}
