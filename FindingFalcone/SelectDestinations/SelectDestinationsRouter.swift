//
// SelectDestinationsRouter.swift
//  FindingFalcone
//
//  Created by Pallab Maiti on 10/03/24.
//

import Foundation
import SwiftUI

final class SelectDestinationsRouter {
    func navigateToNextScreen(
        dataModel: SelectDestinationsDataModel,
        token: Token?,
        onStartAgain: @escaping () -> Void
    ) -> some View {
        return FindFalconeView().configureView(
            dataModel: dataModel,
            token: token,
            onStartAgain: onStartAgain
        )
    }
}
