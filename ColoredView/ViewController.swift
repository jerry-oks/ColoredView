//
//  ViewController.swift
//  ColoredView
//
//  Created by HOLY NADRUGANTIX on 27.07.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var redComponentLabel: UILabel!
    @IBOutlet var greenComponentLabel: UILabel!
    @IBOutlet var blueComponentLabel: UILabel!
    
    @IBOutlet var redComponentSlider: UISlider!
    @IBOutlet var greenComponentSlider: UISlider!
    @IBOutlet var blueComponentSlider: UISlider!
    
    @IBOutlet var colorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 12
        magicColorButtonTapped()
    }

    private func valueChanged(of slider: UISlider, _ label: UILabel) {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redComponentSlider.value),
            green: CGFloat(greenComponentSlider.value),
            blue: CGFloat(blueComponentSlider.value),
            alpha: 1
        )
        label.text = String(format: "%.2f", slider.value)
    }
    
    @IBAction func redSliderValueChanged() {
        valueChanged(of: redComponentSlider, redComponentLabel)
    }
    @IBAction func greenSliderValueChanged() {
        valueChanged(of: greenComponentSlider, greenComponentLabel)
    }
    @IBAction func blueSliderValueChanged() {
        valueChanged(of: blueComponentSlider, blueComponentLabel)
    }
    
    @IBAction func magicColorButtonTapped() {
        redComponentSlider.value = Float.random(in: 0...1)
        greenComponentSlider.value = Float.random(in: 0...1)
        blueComponentSlider.value = Float.random(in: 0...1)

        redSliderValueChanged()
        greenSliderValueChanged()
        blueSliderValueChanged()
    }
    
}

