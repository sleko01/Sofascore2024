import Foundation
import SnapKit
import UIKit
import KeychainAccess

class LoginViewController: UIViewController {
    
    private let loginView: LoginView = .init()
    private let loginButton: UIButton = .init()
    private var buttonAction: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .surfaceSurface1
        addViews()
        styleViews()
        setupConstraints()
    }
    
    func addViews() {
        view.addSubview(loginView)
        view.addSubview(loginButton)
    }
    
    func setupConstraints() {
        loginView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(300)
        }
        loginButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginView.snp.bottom).offset(20)
        }
    }
    
    func styleViews() {
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        loginButton.tintColor = .colorPrimaryVariant
        loginButton.setTitleColor(.black, for: .normal)
        
        loginButton.layer.borderColor = UIColor.colorPrimaryVariant.cgColor
        loginButton.layer.borderWidth = 2.0
        
        loginButton.layer.cornerRadius = 8.0
    }
    
    @objc
    func buttonTapped() {
        if (String.checkEmailFormatIsValid(email: loginView.getEmailField()) && String.checkPasswordFormatIsValid(password: loginView.getPasswordString())) {
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.startAnimating()
            loginView.addSubview(activityIndicator)
            activityIndicator.center = loginView.center
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
                
                let keychain = Keychain()
                do {
                    try keychain.set("token", key: "sofascore")
                } catch let error {
                    print(error)
                }
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Login alert", message: "Email or password in wrong format!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK!", comment: "Default action"), style: .default, handler: { _ in NSLog("The \"OK\" alert occured.")}))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}
