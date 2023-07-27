//
//  ViewController.swift
//  ColoredView
//
//  Created by HOLY NADRUGANTIX on 27.07.2023.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet private var redComponentLabel: UILabel!
    @IBOutlet private var greenComponentLabel: UILabel!
    @IBOutlet private var blueComponentLabel: UILabel!
    
    @IBOutlet private var redComponentSlider: UISlider!
    @IBOutlet private var greenComponentSlider: UISlider!
    @IBOutlet private var blueComponentSlider: UISlider!
    
    @IBOutlet private var colorView: UIView!
    
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
    
    @IBAction private func redSliderValueChanged() {
        valueChanged(of: redComponentSlider, redComponentLabel)
    }
    @IBAction private func greenSliderValueChanged() {
        valueChanged(of: greenComponentSlider, greenComponentLabel)
    }
    @IBAction private func blueSliderValueChanged() {
        valueChanged(of: blueComponentSlider, blueComponentLabel)
    }
    
    @IBAction private func magicColorButtonTapped() {
        redComponentSlider.setValue(Float.random(in: 0...1), animated: true)
        greenComponentSlider.setValue(Float.random(in: 0...1), animated: true)
        blueComponentSlider.setValue(Float.random(in: 0...1), animated: true)
        
        redSliderValueChanged()
        greenSliderValueChanged()
        blueSliderValueChanged()
    }
    
}

