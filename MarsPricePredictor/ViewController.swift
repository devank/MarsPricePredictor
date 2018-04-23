//
//  ViewController.swift
//  MarsPricePredictor
//
//  Created by Devan on 23/04/18.
//  Copyright © 2018 Devan K. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    @IBOutlet weak var solarPanelSegment: TTSegmentedControl!
    @IBOutlet weak var greenHouseSegment: TTSegmentedControl!
    @IBOutlet weak var acreSegment: TTSegmentedControl!
    @IBOutlet weak var priceLabel: UILabel!
    
    let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        formatter.usesGroupingSeparator = true
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        self.setupControls()
        self.updatePriceLabel(solarPanelValue: 1.0, greenhouseValue: 1.0, acresValue: 750)
    }
    func setupControls() {
        self.acresControls()
        self.greenhouseControls()
        self.solarPanelControls()
    }
    func acresControls() {
        let values = [750, 1000, 1500, 2000, 3000, 4000, 5000, 10_000]
        self.acreSegment.itemTitles = values.map({ (item) -> String in
            return String(item)
        })
        self.acreSegment.didSelectItemWith = {
            (index, title) -> () in
            self.updatePriceLabel()
        }
    }
    func greenhouseControls() {
        let values = [1, 2, 3, 4, 5]
        self.greenHouseSegment.itemTitles = values.map({ (item) -> String in
            return String(item)
        })
        self.greenHouseSegment.didSelectItemWith = {
            (index, title) -> () in
            self.updatePriceLabel()
        }
    }
    func solarPanelControls() {
        let values = [1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5]
        self.solarPanelSegment.itemTitles = values.map({ (item) -> String in
            return String(item)
        })
        self.solarPanelSegment.didSelectItemWith = {
            (index, title) -> () in
            self.updatePriceLabel()
        }
    }
    func updatePriceLabel() {
        let solarPanelValue = Double(self.solarPanelSegment.titleForItemAtIndex(self.solarPanelSegment.currentIndex))
        let greenhouseValue = Double(self.greenHouseSegment.titleForItemAtIndex(self.greenHouseSegment.currentIndex))
        let acresValue = Double(self.acreSegment.titleForItemAtIndex(self.acreSegment.currentIndex))
        updatePriceLabel(solarPanelValue: solarPanelValue!, greenhouseValue: greenhouseValue!, acresValue: acresValue!)
    }
    func updatePriceLabel(solarPanelValue: Double, greenhouseValue: Double, acresValue: Double) {
        let price = PricePredictor.instance.predictPrice(solarPanels: solarPanelValue, greenhouses: greenhouseValue, acres: acresValue)
        priceLabel.text = priceFormatter.string(for: price)
    }
}

