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
        dalleImageView.layer.borderWidth = 0.3
        dalleImageView.layer.borderColor = UIColor.black.withAlphaComponent(0.9).cgColor
    }
    
    // MARK: - Variable
    
    private let buttonTitles = ["빈센트 반 고흐", "파블로 피카소", "클로드 모네", "폴 고갱","마르쉘 뒤샹", "램브란트", "키스 해링", "장 미셸 바스키아", "앤디 워홀", "직접 입력"]
    
    // MARK: - Components
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(DrawCollectionViewCell.self, forCellWithReuseIdentifier: "DrawCollectionViewCell")
        return collectionView
    }()
    
    private let dalleImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "gogh")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let dallePrompt: UITextField = {
        let text = UITextField()
        text.backgroundColor = .systemGray6
        text.placeholder = "케이크의 디자인을 텍스트로 표현하세요"
        text.font = UIFont.myFontR.withSize(14)
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
        button.titleLabel?.font = UIFont.myFontM.withSize(14)
        button.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGray2
        button.tintColor = .white
        button.setTitle("저장하기", for: .normal)
        button.titleLabel?.font = UIFont.myFontM.withSize(16)
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
        self.view.addSubview(collectionView)
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
        
        collectionView.topAnchor.constraint(equalTo: dallePrompt.bottomAnchor, constant: 20).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
////        dalleImageView.topAnchor.constraint(greaterThanOrEqualTo: dallePrompt.bottomAnchor, constant: 10).isActive = true
////        dalleImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        dalleImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
//        dalleImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
////        dalleImageView.widthAnchor.constraint(lessThanOrEqualTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
//        dalleImageView.heightAnchor.constraint(equalTo: dalleImageView.widthAnchor).isActive = true
////        dalleImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
////        dalleImageView.bottomAnchor.constraint(lessThanOrEqualTo: self.saveButton.topAnchor, constant: -10).isActive = true
  
        dalleImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        dalleImageView.heightAnchor.constraint(equalTo: dalleImageView.widthAnchor, multiplier: 1.0).isActive = true
        dalleImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        dalleImageView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -40).isActive = true
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func sendButtonTapped() {
        
        guard let inputText = dallePrompt.text else {
            print("nothing")
            return
        }
        
        var promptText: String = inputText
        
        if getSelectedButtonTitle() != nil && getSelectedButtonTitle() != "직접 입력" {
           promptText = inputText + "를 그린 " + getSelectedButtonTitle()! + "의 그림풍의 그림"
        }
        
        let words = inputText.split(separator: " ")
        
        if words.count < 2 {
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
                           let translatedText = try await tranlator.translate(source: "ko", target: "en", text: promptText)
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


extension DrawViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DrawCollectionViewCell", for: indexPath) as! DrawCollectionViewCell
        cell.configure(with: buttonTitles[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let buttonTitle = buttonTitles[indexPath.item]
        let buttonSize = (buttonTitle as NSString).size(withAttributes: [.font: UIFont.systemFont(ofSize: 16)])
        return CGSize(width: buttonSize.width + 20, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DrawCollectionViewCell
        cell.isSelectedCell.toggle()
        for index in 0..<buttonTitles.count {
            if index != indexPath.item {
                if let otherCell = collectionView.cellForItem(at: IndexPath(item: index, section: indexPath.section)) as? DrawCollectionViewCell {
                    otherCell.isSelectedCell = false
                }
            }
        }
    }
    
    func getSelectedButtonTitle() -> String? {
        for index in 0..<buttonTitles.count {
            if let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? DrawCollectionViewCell {
                if cell.isSelectedCell {
                    return buttonTitles[index]
                }
            }
        }
        return nil
    }
}
