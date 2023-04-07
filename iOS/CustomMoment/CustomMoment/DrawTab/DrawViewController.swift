//
//  DrawViewController.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/07.
//


import UIKit

class DrawViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        imageLayout()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        dalleImageView.layer.cornerRadius = dalleImageView.frame.height / 2
        dalleImageView.clipsToBounds = true
        dalleImageView.layer.borderWidth = 1
        dalleImageView.layer.borderColor = UIColor.black.withAlphaComponent(0.9).cgColor
    }
    
    // MARK: - Components
    private let dalleImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "gogh")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let dallePrompt: UITextField = {
        let text = UITextField()
//        text.layer.borderWidth = 0.4
        text.backgroundColor = .systemGray6
//        text.becomeFirstResponder()
        text.placeholder = "케이크의 디자인을 텍스트로 표현하세요"
        text.borderStyle = .roundedRect
        text.clearButtonMode = .whileEditing
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemRed
        button.tintColor = .white
        button.setTitle("생성", for: .normal)
        button.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGray4
        button.tintColor = .white
        button.setTitle("저장하기", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func configure() {
        dallePrompt.delegate = self
        
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height ?? 83
        
        self.view.addSubview(sendButton)
        self.view.addSubview(saveButton)
        self.view.addSubview(dallePrompt)
        self.view.addSubview(dalleImageView)
        
        sendButton.topAnchor.constraint(equalTo: bottomBoarder.bottomAnchor, constant: 10).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        saveButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(tabBarHeight + 10)).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        saveButton.topAnchor.constraint(equalTo: dalleImageView.bottomAnchor, constant: 10).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        dallePrompt.topAnchor.constraint(equalTo: bottomBoarder.bottomAnchor, constant: 10).isActive = true
        dallePrompt.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        dallePrompt.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -10).isActive = true
        dallePrompt.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
//        dalleImageView.topAnchor.constraint(greaterThanOrEqualTo: dallePrompt.bottomAnchor, constant: 10).isActive = true
//        dalleImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        dalleImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        dalleImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
//        dalleImageView.widthAnchor.constraint(lessThanOrEqualTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        dalleImageView.heightAnchor.constraint(equalTo: dalleImageView.widthAnchor).isActive = true
//        dalleImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//        dalleImageView.bottomAnchor.constraint(lessThanOrEqualTo: self.saveButton.topAnchor, constant: -10).isActive = true
        
    }
    
    // MARK: - Logo Layout
    
    private lazy var logo: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(homeButtonTapped))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var bottomBoarder = UIImageView(frame: CGRect(x: 0, y: 96.6, width: self.view.frame.width, height: 0.5))
    
    // 로고 터치 처리
    func imageLayout() {
        self.view.addSubview(logo)
        self.view.addSubview(bottomBoarder)
        
        logo.topAnchor.constraint(
            equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 1).isActive = true
        logo.centerXAnchor.constraint(
            equalTo: self.view.centerXAnchor).isActive = true
        logo.widthAnchor.constraint(
            equalTo: self.view.widthAnchor, multiplier: 0.2).isActive = true
        logo.heightAnchor.constraint(
            equalTo: self.view.heightAnchor, multiplier: 0.045).isActive = true
        logo.contentMode = .scaleAspectFit
        
        bottomBoarder.backgroundColor = .black.withAlphaComponent(0.6)
        bottomBoarder.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
    }
    
    @objc func homeButtonTapped() {
        tabBarController?.selectedIndex = 0
    }
    
}

extension DrawViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let inputText = textField.text else {
            print("nothing")
            return
        }
        
        let words = inputText.split(separator: " ")
        
        if words.count < 7 {
            let alertController = UIAlertController(title: "경고", message: "정확한 케이크 이미지 생성을 위해 10단어 이상 입력하세요!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func sendButtonTapped() {
        print("send Button Tapped")
        
        guard let inputText = dallePrompt.text else {
            print("nothing")
            return
        }
        let words = inputText.split(separator: " ")
        
        if words.count < 7 {
            let alertController = UIAlertController(title: "경고", message: "정확한 케이크 이미지 생성을 위해 7글자 이상 입력하세요!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true)
            
        } else {
            let alertController = UIAlertController(title: "확인!", message: "해당 문장으로 진행하시겠습니까?", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { [weak self] _ in
                guard self != nil else { return }
                
                guard let clientID = Bundle.main.object(forInfoDictionaryKey: "PAPAGO_API_ID") as? String else { return }
                guard let clientKey = Bundle.main.object(forInfoDictionaryKey: "PAPAGO_API_PW") as? String else { return  }
                
                let tranlator = NaverTranslator(clientId: clientID, clientSecret: clientKey)

                Task {
                       do {
                           let translatedText = try await tranlator.translate(source: "ko", target: "en", text: inputText)
                           print(translatedText)

                           let image = try await DalleAPIService().fetchImageForPrompt(translatedText)
                           await MainActor.run {
                               self?.dalleImageView.image = image
                           }
                       
                       } catch {
                           print(error)
                       }
                   }
                 
            }))
            
            alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func saveButtonTapped() {
        saveImage()
    }
    
    func saveImage() {
        guard let image = dalleImageView.image else {
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            let alertController = UIAlertController(title: "성공", message: "성공적으로 저장하였습니다!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
}


