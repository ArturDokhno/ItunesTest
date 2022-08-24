//
//  SignUpViewController.swift
//  ItunesTest
//
//  Created by Артур Дохно on 25.05.2022.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Registration"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "First name"
        return textField
    }()
    
    private let firstNameValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Second name"
        return textField
    }()
    
    private let secondNameValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ageValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Phone"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let phoneValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let emailValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let passwordValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Required field"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("SignUp", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var elementsStackView = UIStackView()
    private let datePicker = UIDatePicker()
    
    let nameValidType: String.ValidTypes = .name
    let emailValidType: String.ValidTypes = .email
    let passwordValidType: String.ValidTypes = .password
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setupDelegate()
        setupDataPicker()
        registerKeyboardNotification()
    }
    
    deinit {
        removeKeyboardNotification()
    }
    
    private func setupViews() {
        title = "SignUp"
        
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        
        elementsStackView = UIStackView(arrangedSubviews: [firstNameTextField,
                                                           firstNameValidLabel,
                                                           secondNameTextField,
                                                           secondNameValidLabel,
                                                           datePicker,
                                                           ageValidLabel,
                                                           phoneNumberTextField,
                                                           phoneValidLabel,
                                                           emailTextField,
                                                           emailValidLabel,
                                                           passwordTextField,
                                                           passwordValidLabel],
                                        axis: .vertical,
                                        spacing: 10,
                                        distribution: .fillProportionally)
        
        backgroundView.addSubview(elementsStackView)
        backgroundView.addSubview(loginLabel)
        backgroundView.addSubview(signUpButton)
    }
    
    private func setupDelegate() {
        firstNameTextField.delegate = self
        secondNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setupDataPicker() {
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        datePicker.layer.borderColor = #colorLiteral(red: 0.8810099265, green: 0.8810099265, blue: 0.8810099265, alpha: 1)
        datePicker.layer.borderWidth = 1
        datePicker.clipsToBounds = true
        datePicker.layer.cornerRadius = 6
        datePicker.tintColor = .black
    }
    
    @objc func signUpButtonTapped() {
        print("SignUpTap")
    }
    
    private func setTextfield(textField: UITextField, label: UILabel, validType: String.ValidTypes, validMessage: String, wrongMessage: String, string: String, range: NSRange) {
        
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        
        textField.text = result
        
        if result.isValid(validType: validType) {
            label.text = validMessage
            label.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        } else {
            label.text = wrongMessage
            label.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
    }
    
    private func setPhoneNumberMask(textField: UITextField, mask: String, string: String, range: NSRange) -> String {
        
        let text = textField.text ?? ""
        
        let phone = (text as NSString).replacingCharacters(in: range, with: string)
        let number = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = number.startIndex
        
        for character in mask where index < number.endIndex {
            if character == "X" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(character)
            }
        }
        
        if result.count == 18 {
            phoneValidLabel.text = "Phone is valid"
            phoneValidLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        } else {
            phoneValidLabel.text = "Phone is not valid"
            phoneValidLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
        
        return result
    }
    
    private func ageIsValid() -> Bool {
        let calendar = NSCalendar.current
        let dateNow = Date()
        let birthday = datePicker.date
        
        let age = calendar.dateComponents([.year], from: birthday, to: dateNow)
        let ageYear = age.year
        guard let ageUser = ageYear else { return false }
        return ageUser < 18 ? false : true
    }
    
}
//MARK: - UITextFieldDelegate

extension SignUpViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
 
        switch textField {
                
            case firstNameTextField:
                setTextfield(textField: firstNameTextField,
                             label: firstNameValidLabel,
                             validType: nameValidType,
                             validMessage: "Name is valid",
                             wrongMessage: "Only A-Z characters ",
                             string: string,
                             range: range)
                
            case secondNameTextField:
                setTextfield(textField: secondNameTextField,
                             label: secondNameValidLabel,
                             validType: nameValidType,
                             validMessage: "Name is valid",
                             wrongMessage: "Only A-Z characters ",
                             string: string,
                             range: range)
                
            case emailTextField:
                setTextfield(textField: emailTextField,
                             label: emailValidLabel,
                             validType: emailValidType,
                             validMessage: "Email is valid",
                             wrongMessage: "Email is not valid",
                             string: string,
                             range: range)
                
            case passwordTextField:
                setTextfield(textField: passwordTextField,
                             label: passwordValidLabel,
                             validType: passwordValidType,
                             validMessage: "Password is valid",
                             wrongMessage: "Password is not valid",
                             string: string,
                             range: range)
            case phoneNumberTextField:
                phoneNumberTextField.text = setPhoneNumberMask(textField: phoneNumberTextField,
                                                               mask: "+X (XXX) XXX-XX-XX",
                                                               string: string,
                                                               range: range)
                
            default:
                break
        }
        
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTextField.resignFirstResponder()
        secondNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }

}

// MARK: - Show/Hide keyboard

extension SignUpViewController {
    
    private func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardHide = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardHide.height / 2)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        scrollView.contentOffset = CGPoint.zero
    }
    
}

//MARK: - SetConstraints

extension SignUpViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            backgroundView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            backgroundView.heightAnchor.constraint(equalTo: view.heightAnchor),
            backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            elementsStackView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            elementsStackView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            elementsStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            elementsStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            loginLabel.bottomAnchor.constraint(equalTo: elementsStackView.topAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            signUpButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: elementsStackView.bottomAnchor, constant: 30),
            signUpButton.widthAnchor.constraint(equalToConstant: 300),
            signUpButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}
