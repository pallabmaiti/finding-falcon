//
//  FindFalconRouter.swift
//  FindingFalcon
//
//  Created by Pallab Maiti on 10/03/24.
//

import Foundation
import SwiftUI

final class FindFalconRouter {
    func navigateToNextScreen(
        dataModel: FindFalconDataModel,
        token: Token?,
        onStartAgain: @escaping () -> Void
    ) -> some View {
        return FoundFalconView().configureView(
            dataModel: dataModel,
            token: token,
            onStartAgain: onStartAgain
        )
    }
}
