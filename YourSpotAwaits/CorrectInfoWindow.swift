//
//  CorrectInfoWindow.swift
//  YourSpotAwaits
//
//  Created by Kendall McCaskill on 4/4/18.
//  Copyright © 2018 YourSpotAwaits. All rights reserved.
//

import UIKit
import Charts
import ChartsRealm

class CorrectInfoWindow: UIView, ChartViewDelegate {
    
    @IBOutlet weak var parkingLotTitleLabel: UILabel!
    @IBOutlet weak var parkingLotSpacesAvailable: UILabel!
    
    let spacesOpenChart: PieChartView = {
        let p = PieChartView()
        p.translatesAutoresizingMaskIntoConstraints = false
        p.noDataText = "No number to display"
        p.chartDescription?.text = ""
        p.drawHoleEnabled = true
        p.delegate = p.self as? ChartViewDelegate
        return p
    }()
    
    func setupPieChart() {
        self.addSubview(spacesOpenChart)
        spacesOpenChart.topAnchor.constraint(equalTo: parkingLotSpacesAvailable.bottomAnchor, constant: 10).isActive = true
        spacesOpenChart.widthAnchor.constraint(equalToConstant: 258).isActive = true
        spacesOpenChart.heightAnchor.constraint(equalToConstant: 210).isActive = true
        spacesOpenChart.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    let parkingData = ["Green": 50, "Blue": 30, "Red": 10]
    
    func fillChart() {
        var dataEntries = [PieChartDataEntry]()
        for (key, val) in parkingData {
            let entry = PieChartDataEntry(value: Double(val), label: key)
            dataEntries.append(entry)
        }
        
        let colors = [UIColor.green, UIColor.blue, UIColor.red]
        
        let chartDataSet = PieChartDataSet(values: dataEntries, label: "")
        chartDataSet.colors = colors
        chartDataSet.sliceSpace = 2
        chartDataSet.selectionShift = 3
        
        let chartData = PieChartData(dataSet: chartDataSet)
        
        spacesOpenChart.data = chartData
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let index = highlight.y
        print("Selected \(index)")
    }
    
    func instanceFromNib() -> UIView {
        return UINib(nibName: "CorrectInfoWindowView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
    }
    
}
