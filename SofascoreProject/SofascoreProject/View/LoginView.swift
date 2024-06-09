import Foundation
import UIKit
import SnapKit
import SofaAcademic

class LoginView: BaseView, UITextFieldDelegate {
    
    private let emailField: UITextField = .init()
    private let passwordField: UITextField = .init()
    
    override func addViews() {
        addSubview(emailField)
        addSubview(passwordField)
    }
    
    override func setupConstraints() {
        emailField.snp.makeConstraints {
            $0.centerX.equalToSuperview() 
            $0.centerY.equalToSuperview().offset(-50) 
            $0.width.equalTo(250) 
            $0.height.equalTo(40)
        }

        passwordField.snp.makeConstraints {
            $0.centerX.equalToSuperview() 
            $0.centerY.equalToSuperview().offset(50)
            $0.width.equalTo(250)
            $0.height.equalTo(40)
        }
    }
    
    override func styleViews() {
        emailField.placeholder = "Email"
        passwordField.placeholder = "Password"
        
        emailField.borderStyle = .roundedRect
        passwordField.borderStyle = .roundedRect
        
        passwordField.isSecureTextEntry = true
        
        emailField.textAlignment = .left
        emailField.adjustsFontSizeToFitWidth = true
        emailField.minimumFontSize = 12
        emailField.autocorrectionType = .no
        emailField.clearButtonMode = .whileEditing
        emailField.returnKeyType = .done

        passwordField.textAlignment = .left
        passwordField.adjustsFontSizeToFitWidth = true
        passwordField.minimumFontSize = 12
        passwordField.autocorrectionType = .no
        passwordField.clearButtonMode = .whileEditing
        passwordField.returnKeyType = .done
    }
}

extension LoginView {
    
    func getEmailField() -> String {
        if let emailFieldText = emailField.text {
            return emailFieldText
        }
        return ""
    }
    
    func getPasswordString() -> String {
        if let passwordFieldString = passwordField.text {
            return passwordFieldString
        }
        return ""
    }
}
