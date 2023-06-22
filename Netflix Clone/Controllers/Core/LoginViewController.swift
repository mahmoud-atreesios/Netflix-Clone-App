//
//  ViewController.swift
//  LoginPage
//
//  Created by Mahmoud Mohamed Atrees on 02/06/2023.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    
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
    
    private let usernameTextField: UITextField = {
        
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(
            string: "  username",
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
        field.isSecureTextEntry = true
        field.textColor = .black
        return field
    }()
    private let signUpButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("New User? Create Account", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        return button
        
    }()
    
    private let loginButton: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.setTitle("Login", for: .normal)
        button.layer.cornerRadius = 6
        return button
        
    }()
    
    @objc func didTapLoginButton(sender: UIButton){
        
        guard let email = usernameTextField.text else{return}
        guard let password = passwordTextField.text else{return}
        
        Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
            if error != nil{
                
                let alert = UIAlertController(title: "Oops!", message:"The email and password didn't match try again!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay.", style: .default) { _ in })
                self.present(alert, animated: true)
                
            }else{
                let vc = MainTabBarViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                self.loginButton.addTarget(self, action: #selector(self.didTapLoginButton), for: .touchUpInside)
               // (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(HomeViewController)
            }
          
        }
        
    }
    
   
    let imagee = UIImage(named: "poster1")
    var imageeView : UIImageView!
    
    let image = UIImage(named: "mainLabel")
    var imageView : UIImageView!
    
   
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        imageeView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        imageeView.contentMode = .scaleAspectFill
        imageeView.image = imagee
        view.addSubview(imageeView)
        self.view.backgroundColor = UIColor(patternImage: imagee!)
        
        imageView = UIImageView(frame: CGRect(x: 5, y: 80, width: 400, height: 250))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        view.addSubview(imageView)
        
        
        // Do any additional setup after loading the view.
      
        self.signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        self.loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
                
        view.addSubview(usernameTextField)
        view.addSubview(usernameLabel)
        
        view.addSubview(passwordTextField)
        view.addSubview(passwordLabel)
        
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
        
        
        
        configureNavBar()
        hideKeyboardWhenTappedAround()
        
        self.tabBarController?.tabBar.isHidden = false
        
        
    }
    
    @objc func didTapSignUpButton(sender: UIButton){
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
  
    
    
    private func configureNavBar(){
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 10, y: 0, width: 25, height: 35 )
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 35)));
        view.addSubview(button);
        let leftButton = UIBarButtonItem(customView: view)
        self.navigationItem.leftBarButtonItem = leftButton
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        usernameTextField.frame = CGRect(x: 40, y: 350, width: 320, height: 40)
        usernameLabel.frame = CGRect(x: 40, y: 300, width: 250, height: 50)
        
        passwordTextField.frame = CGRect(x: 40, y: 450, width: 320, height: 40)
        passwordLabel.frame = CGRect(x: 40, y: 400, width: 250, height: 50)
        
        loginButton.frame = CGRect(x: 50, y: 510, width: 300, height: 40)
        signUpButton.frame = CGRect(x: 50, y: 550, width: 300, height: 40)
        
        
        
    }
    
    func assignbackground(){
        let background = UIImage(named: "posterr")
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    
}

extension LoginViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
