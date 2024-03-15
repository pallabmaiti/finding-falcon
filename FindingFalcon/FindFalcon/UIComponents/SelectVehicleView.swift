//
//  SelectVehicleView.swift
//  FindingFalcon
//
//  Created by Pallab Maiti on 05/03/24.
//

import SwiftUI

struct SelectVehicleView: View {
    let vehicle: Vehicle
    let selectedVehicle: Vehicle?
    let onSelectVehicle: (Vehicle) -> Void
    
    init(
        vehicle: Vehicle,
        selectedVehicle: Vehicle?,
        onSelectVehicle: @escaping (Vehicle) -> Void
        ) {
        self.vehicle = vehicle
        self.selectedVehicle = selectedVehicle
        self.onSelectVehicle = onSelectVehicle
    }
    
    var body: some View {
        Button(action:{
            self.onSelectVehicle(self.vehicle)
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: selectedVehicle?.name == vehicle.name ? "largecircle.fill.circle" : "circle")
                Text("\(vehicle.name) (\(selectedVehicle?.name == vehicle.name ? (vehicle.totalNo - 1) : vehicle.totalNo))")
                Spacer()
            }
        }
        .buttonStyle(.borderless)
        .frame(height: 30)
    }
}
