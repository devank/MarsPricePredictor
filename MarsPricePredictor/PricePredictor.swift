//
//  PricePredictor.swift
//  MarsPricePredictor
//
//  Created by Devan on 23/04/18.
//  Copyright © 2018 Devan K. All rights reserved.
//

import Foundation
import CoreML

class PricePredictor {
    static let instance: PricePredictor = PricePredictor()
    private var model: MarsHabitatPricer
    private init() {
        model = MarsHabitatPricer()
    }
    func predictPrice(solarPanels: Double, greenhouses: Double, acres: Double) -> Double {
        guard let priceOutput = try? model.prediction(solarPanels: solarPanels, greenhouses: greenhouses, size: acres) else {
            fatalError("Runtime Error")
        }
        return priceOutput.price
    }
}
