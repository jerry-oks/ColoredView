//
//  ViewController.swift
//  ColoredView
//
//  Created by HOLY NADRUGANTIX on 27.07.2023.
//

import UIKit

final class SettingViewController: UIViewController {
    // MARK: - Public Properties
    var color: UIColor!
    
    weak var delegate: SettingViewControllerDelegate?
    
    // MARK: - IB Outlets
    @IBOutlet private var colorView: UIView!
    @IBOutlet private var componentsView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet private var redTF: UITextField!
    @IBOutlet private var greenTF: UITextField!
    @IBOutlet private var blueTF: UITextField!
    
    @IBOutlet private var redSlider: UISlider!
    @IBOutlet private var greenSlider: UISlider!
    @IBOutlet private var blueSlider: UISlider!
    
    @IBOutlet private var stackView: UIStackView!
        
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTF.delegate = self
        greenTF.delegate = self
        blueTF.delegate = self
        
        colorView.layer.cornerRadius = 12
        colorView.backgroundColor = color
        
        componentsView.layer.cornerRadius = 8
        
        setSlidersValues(from: color)
        setTFText(forColors: .red, .green, .blue)
        setLabelText(forColors: .red, .green, .blue)
        
        addToolBar(for: redTF, greenTF, blueTF)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NSLayoutConstraint.activate([
            view.keyboardLayoutGuide.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20)
        ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)])
    }
    
    // MARK: - UI Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
    // MARK: - IB Actions
    @IBAction private func sliderValueChanged(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setTFText(forColors: .red)
            setLabelText(forColors: .red)
        case greenSlider:
            setTFText(forColors: .green)
            setLabelText(forColors: .green)
        default:
            setTFText(forColors: .blue)
            setLabelText(forColors: .blue)
        }
        
        setColor()
    }
    
    @IBAction private func tfTextChanged(_ sender: UITextField) {
        if checkRequirements(for: sender) {
            switch sender {
            case redTF:
                setSliderValue(forColors: .red)
                setLabelText(forColors: .red)
            case greenTF:
                setSliderValue(forColors: .green)
                setLabelText(forColors: .green)
            default:
                setSliderValue(forColors: .blue)
                setLabelText(forColors: .blue)
            }
            
            sender.textColor = .label
            setColor()
        } else {
            sender.textColor = .systemRed
        }
    }
    
    @IBAction private func magicColorButtonTapped() {
        setRandomColor()
    }
    
    @IBAction private func saveButtonTapped() {
        if !checkRequirements(for: redTF, greenTF, blueTF) {
            showAlert(
                withTitle: "Wrong input",
                message: "Check if your text fields contains correct values",
                buttonTitle: "ОК",
                andMakeFirstResponder: view
            )
            return
        }
        
        delegate?.setMainViewColor(from: colorView)
        dismiss(animated: true)
    }
}

// MARK: - Private Methods
private extension SettingViewController {
    // Color Enumeration
    enum Color {
        case red
        case green
        case blue
    }
    
    // Set Color From Sliders Method
    func setColor() {
        colorView.backgroundColor = UIColor(
            red: redSlider.value.cgFloat(),
            green: greenSlider.value.cgFloat(),
            blue: blueSlider.value.cgFloat(),
            alpha: 1
        )
    }
    
    // Set Sliders Values From MainVC View Background Color Method
    func setSlidersValues(from color: UIColor) {
        redSlider.value = (color.cgColor.components?[0] ?? 0).float()
        greenSlider.value = (color.cgColor.components?[1] ?? 0).float()
        blueSlider.value = (color.cgColor.components?[2] ?? 0).float()
    }
    
    // Set TF Text Method From Slider Value Method
    func setTFText(forColors colors: Color...) {
        colors.forEach { color in
            switch color {
            case .red:
                redTF.text = redSlider.value.string()
                if redTF.textColor != .label {
                    redTF.textColor = .label
                }
            case .green:
                greenTF.text = greenSlider.value.string()
                if greenTF.textColor != .label {
                    greenTF.textColor = .label
                }
            default:
                blueTF.text = blueSlider.value.string()
                if blueTF.textColor != .label {
                    blueTF.textColor = .label
                }
            }
        }
    }
    
    // Set Label Text From Slider Value Method
    func setLabelText(forColors colors: Color...) {
        colors.forEach { color in
            switch color {
            case .red: redLabel.text = redSlider.value.string()
            case .green: greenLabel.text = greenSlider.value.string()
            default: blueLabel.text = blueSlider.value.string()
            }
        }
    }
    
    // Set Slider Value From TF Method
    func setSliderValue(forColors colors: Color...) {
        colors.forEach { color in
            switch color {
            case .red: redSlider.setValue(redTF.text?.float() ?? 0, animated: true)
            case .green: greenSlider.setValue(greenTF.text?.float() ?? 0, animated: true)
            default: blueSlider.setValue(blueTF.text?.float() ?? 0, animated: true)
            }
        }
    }
    
    // Set Random Color Method
    func setRandomColor() {
        redSlider.setValue(Float.random(in: 0...1), animated: true)
        greenSlider.setValue(Float.random(in: 0...1), animated: true)
        blueSlider.setValue(Float.random(in: 0...1), animated: true)
        
        setTFText(forColors: .red, .green, .blue)
        setLabelText(forColors: .red, .green, .blue)
        
        setColor()
    }
    
    // Check Requirements For TF Method
    func checkRequirements(for textFields: UITextField...) -> Bool {
        var checks: [Bool] = []
        
        textFields.forEach { textField in
            if let textFieldText = textField.text {
                    if textFieldText.count < 5 {
                        if let floatTextFieldText = Float(textFieldText) {
                            if floatTextFieldText >= 0 && floatTextFieldText <= 1 {
                                checks.append(true)
                        }
                    }
                }
            }
        }
        
        return textFields.count == checks.count
    }
    
    // Show Alert Method
    func showAlert(withTitle title: String, message: String, buttonTitle: String, andMakeFirstResponder view: UIView) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let buttonAction = UIAlertAction(title: buttonTitle, style: .default) { _ in
            view.becomeFirstResponder()
        }
        
        alert.addAction(buttonAction)
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate Methods
extension SettingViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !checkRequirements(for: textField) {
            showAlert(
                withTitle: "Wrong input",
                message: "The text field you've just edited contains wrong value",
                buttonTitle: "OK",
                andMakeFirstResponder: textField
            )
        }
        
    }
}


// MARK: - Keyboard Toolbar Methods
private extension SettingViewController {
    func addToolBar(for textFields: UITextField...) {
        textFields.forEach { textField in
            let toolBar = UIToolbar()
            
            let doneButton = UIBarButtonItem(
                title: "Done",
                style: UIBarButtonItem.Style.done,
                target: self,
                action: #selector(doneButtonTapped)
            )
            let space = UIBarButtonItem(
                barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                target: self,
                action: nil
            )
            
            toolBar.setItems([space, doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            toolBar.sizeToFit()
            
            textField.inputAccessoryView = toolBar
        }
    }
    
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
}

// MARK: - Convertation Methods
extension Float {
    func cgFloat() -> CGFloat {
        CGFloat(self)
    }
    func string() -> String {
        String(format: "%.2f", self)
    }
}

extension CGFloat {
    func float() -> Float {
        Float(self)
    }
}

extension String {
    func float() -> Float {
        Float(self) ?? 0
    }
}
