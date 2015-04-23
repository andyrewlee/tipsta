//
//  ViewController.swift
//  tipsta
//
//  Created by Jae Hoon Lee on 4/13/15.
//  Copyright (c) 2015 Jae Hoon Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // Outlets
    @IBOutlet weak var priceWithoutTaxLabel: UILabel!
    
    @IBOutlet weak var firstPercentLabel: UILabel!
    @IBOutlet weak var secondPercentLabel: UILabel!
    @IBOutlet weak var thirdPercentLabel: UILabel!
    
    @IBOutlet weak var firstPercentTip: UILabel!
    @IBOutlet weak var firstPercentTotal: UILabel!
    
    @IBOutlet weak var secondPercentTip: UILabel!
    @IBOutlet weak var secondPercentTotal: UILabel!
    
    @IBOutlet weak var thirdPercentTip: UILabel!
    @IBOutlet weak var thirdPercentTotal: UILabel!
    
    
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var groupSlider: UISlider!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var groupSizeLabel: UILabel!
    @IBOutlet weak var groupSizeStaticLabel: UILabel!
    
    // Actions
    @IBAction func digitButtonPressed(sender: UIButton) {
        println(sender.currentTitle)
        if let buttonPressed = sender.currentTitle {
            if buttonPressed == "c" {
                priceWithoutTaxLabel.text = "0"
            } else {
                if priceWithoutTaxLabel.text == "0" {
                    priceWithoutTaxLabel.text = buttonPressed
                } else {
                    if count(priceWithoutTaxLabel.text!) > 5 {
                        priceWithoutTaxLabel.text = "Too baller"
                    } else {
                        priceWithoutTaxLabel.text = priceWithoutTaxLabel.text! + buttonPressed
                    }
                }
            }
        }
        
        updateTotal()
        updateTips()
    }
    
    @IBAction func tipSliderChanged(sender: UISlider) {
        var senderValue = Int(sender.value)
        var sliderValue = Double(senderValue) * 0.01 + 1
        firstPercent = sliderValue
        secondPercent = sliderValue + 0.05
        thirdPercent = sliderValue + 0.1
        
        firstPercentLabel.text = String(format:"%d", senderValue) + "%"
        secondPercentLabel.text = String(format:"%d", senderValue + 5) + "%"
        thirdPercentLabel.text = String(format:"%d", senderValue + 10) + "%"
        
        updateTotal()
        updateTips()
    }
    
    @IBAction func groupSizeSliderChanged(sender: UISlider) {
        groupSize = Double(round(sender.value))
        
        groupSizeLabel.text = String(format:"%d", Int(groupSize))
        println(groupSize)
        updateTotal()
        updateTips()
    }
    
    // Properties
    var firstPercent = 1.1
    var secondPercent = 1.15
    var thirdPercent = 1.2
    var groupSize: Double = 1
    
    // Methods
    func updateTotal() {
        var valueToCalculate: Double = (priceWithoutTaxLabel.text! as NSString).doubleValue
        valueToCalculate = valueToCalculate/groupSize
        firstPercentTotal.text = String(format:"%.2f", valueToCalculate * firstPercent)
        secondPercentTotal.text = String(format:"%.2f", valueToCalculate * secondPercent)
        thirdPercentTotal.text = String(format:"%.2f", valueToCalculate * thirdPercent)
    }
    
    func updateTips() {
        var valueToCalculate = (priceWithoutTaxLabel.text! as NSString).doubleValue
        valueToCalculate = valueToCalculate/groupSize
        firstPercentTip.text = String(format:"%.2f", (firstPercentTotal.text! as NSString).doubleValue - valueToCalculate)
        
        secondPercentTip.text = String(format:"%.2f", (secondPercentTotal.text! as NSString).doubleValue - valueToCalculate)
        
        thirdPercentTip.text = String(format:"%.2f", (thirdPercentTotal.text! as NSString).doubleValue - valueToCalculate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (self.view.frame.size.height < 568) {
            tipSlider.hidden = true
            groupSlider.hidden = true
            tipPercentageLabel.hidden = true
            groupSizeLabel.hidden = true
            groupSizeStaticLabel.hidden = true
        }
        
        priceWithoutTaxLabel.text = "0"
        firstPercentTip.text = "0.00"
        firstPercentTotal.text = "0.00"
        
        secondPercentTip.text = "0.00"
        secondPercentTotal.text = "0.00"
        
        thirdPercentTip.text = "0.00"
        thirdPercentTotal.text = "0.00"
    }
}

