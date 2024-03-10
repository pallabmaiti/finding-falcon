//
//  SelectVehicleView.swift
//  FindingFalcon
//
//  Created by Pallab Maiti on 05/03/24.
//

import SwiftUI

struct SelectVehicleView: View {
    let vehicle: Vehicle
    let onSelectVehicle: (Vehicle) -> Void
    
    init(
        vehicle: Vehicle,
        onSelectVehicle: @escaping (Vehicle) -> Void
        ) {
        self.vehicle = vehicle
        self.onSelectVehicle = onSelectVehicle
    }
    
    var body: some View {
        Button(action:{
            self.onSelectVehicle(self.vehicle)
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: self.vehicle.selected ? "largecircle.fill.circle" : "circle")
                Text("\(vehicle.name) (\(vehicle.totalNo))")
                Spacer()
            }
        }
        .buttonStyle(.borderless)
        .frame(height: 30)
    }
}
