//
//  MainViewController.swift
//  LoginPage
//
//  Created by Mahmoud Mohamed Atrees on 02/06/2023.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    private let usernameLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Username"
        return label
        
    }()

    private let passwordLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Password"
        return label
        
    }()
    
    public let usernameTextField: UITextField = {
        
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(
            string: "  Email Address",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        field.backgroundColor = .white
        field.layer.cornerRadius = 10
        field.textColor = .black
        return field
    }()
    
    private let passwordTextField: UITextField = {
        
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(
            string: "  password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        field.backgroundColor = .white
        field.layer.cornerRadius = 10
        field.textColor = .black
        return field
    }()
    
    private let registerButton: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.setTitle("Register", for: .normal)
        button.layer.cornerRadius = 6
        return button
        
    }()
    
    @objc func didTapRegisterButton(sender: UIButton){
        
        guard let email = usernameTextField.text else{return}
        guard let password = passwordTextField.text else{return}
        Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
            
            if let e = error{
                let alert = UIAlertController(title: "Oops!", message:"\(e.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay.", style: .default) { _ in })
                self.present(alert, animated: true)
                
            }else{
                let vc = HomeViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                self.registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
            }
        }
 
    }
    


    let imagee = UIImage(named: "Posterrr")
    var imageeView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageeView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        imageeView.contentMode = .scaleAspectFill
        imageeView.image = imagee
        view.addSubview(imageeView)
        self.view.backgroundColor = UIColor(patternImage: imagee!)
        
        view.addSubview(usernameTextField)
        view.addSubview(usernameLabel)
        
        view.addSubview(passwordTextField)
        view.addSubview(passwordLabel)
        
        view.addSubview(registerButton)
        
        hideKeyboardWhenTappedAround()
        self.tabBarController?.tabBar.isHidden = true
        
        self.registerButton.addTarget(self, action: #selector(self.didTapRegisterButton), for: .touchUpInside)


    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
        usernameTextField.frame = CGRect(x: 40, y: 350, width: 320, height: 40)
        usernameLabel.frame = CGRect(x: 40, y: 300, width: 250, height: 50)
        
        passwordTextField.frame = CGRect(x: 40, y: 450, width: 320, height: 40)
        passwordLabel.frame = CGRect(x: 40, y: 400, width: 250, height: 50)
        
        registerButton.frame = CGRect(x: 150, y: 510, width: 100, height: 40)
        
        
        
    }
    



}


extension SignUpViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
