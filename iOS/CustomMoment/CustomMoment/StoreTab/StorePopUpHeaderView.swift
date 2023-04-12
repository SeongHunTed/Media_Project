//
//  StorePopUpHeaderFooterView.swift
//  CustomMoment
//
//  Created by Hoon on 2023/04/02.
//

import UIKit
import NMapsMap

class StorePopUpHeaderView: UICollectionReusableView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.myFontB.withSize(17.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
        
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(label)
        NSLayoutConstraint.activate([
            self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
        ])
        addBottomBorder()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addBottomBorder() {
        let borderLayer = CALayer()
        borderLayer.frame = CGRect(x: 0, y: frame.size.height-10, width: frame.size.width, height: 1)
        borderLayer.backgroundColor = UIColor.lightGray.cgColor
        layer.addSublayer(borderLayer)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(text: nil)
    }
    
    func prepare(text: String?) {
        self.label.text = text
    }
}

class StorePopUpSecondHeaderView: UICollectionReusableView {
    
    private let cakeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("케이크", for: .normal)
        button.titleLabel?.font = UIFont.myFontB.withSize(15.0)
        button.titleLabel?.textColor = .white
        button.tintColor = .white
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 6
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(cakeButton)
        NSLayoutConstraint.activate([
            self.cakeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.cakeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.cakeButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            self.cakeButton.heightAnchor.constraint(equalToConstant: 33)
        ])
        addBottomBorder()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addBottomBorder() {
        let borderLayer = CALayer()
        borderLayer.frame = CGRect(x: 20, y: 53, width: self.frame.size.width-35, height: 1)
        borderLayer.backgroundColor = UIColor.systemRed.cgColor
        layer.addSublayer(borderLayer)
    }
}

class StorePopUpFooterView: UICollectionReusableView {
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "⏰ 영업 : 수~일 10:00~17:00/ 휴무 : 월, 화"
        label.font = UIFont.myFontR.withSize(15.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let digitLabel: UILabel = {
        let label = UILabel()
        label.text = "☎️ 02-222-5555"
        label.font = UIFont.myFontR.withSize(15.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "🚗 서울시 관악구 미성3길 20 1층"
        label.font = UIFont.myFontR.withSize(15.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mapView: UIView = {
        let mapView = UIView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    // Map Object
    private lazy var naverMapView: NMFMapView = {
        let map = NMFMapView(frame: mapView.bounds)
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        map.layer.borderColor = UIColor.systemGray4.cgColor
        map.layer.borderWidth = 0.5
        return map
    }()
    
    // Map Camera Position
    private let cameraUpdate: NMFCameraUpdate = {
        let camera = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 37.5670135, lng: 126.9783740), zoomTo: 14.5)
        return camera
    }()
    
    // Set Store's Marker
    private let marker: NMFMarker = {
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: 37.5670135, lng: 126.9783740)
        return marker
    }()
    
    private func configureMap() {
        naverMapView.moveCamera(cameraUpdate)
        marker.mapView = naverMapView
    }
    
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(timeLabel)
        self.addSubview(digitLabel)
        self.addSubview(addressLabel)
        self.addSubview(mapView)
        self.mapView.addSubview(naverMapView)
        configureMap()

        NSLayoutConstraint.activate([
            
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            digitLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10),
            digitLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            addressLabel.topAnchor.constraint(equalTo: digitLabel.bottomAnchor, constant: 10),
            addressLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            mapView.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 20),
            mapView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mapView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6),
            mapView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            
            naverMapView.topAnchor.constraint(equalTo: mapView.topAnchor),
            naverMapView.bottomAnchor.constraint(equalTo: mapView.bottomAnchor),
            naverMapView.leadingAnchor.constraint(equalTo: mapView.leadingAnchor),
            naverMapView.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
        ])
        addBottomBorder()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addBottomBorder() {
        let bottomBorderLayer = CALayer()
        bottomBorderLayer.frame = CGRect(x: 0, y: frame.size.height - 1, width: frame.size.width, height: 1)
        bottomBorderLayer.backgroundColor = UIColor.lightGray.cgColor
        let topBorderLayer = CALayer()
        topBorderLayer.frame = CGRect(x: 0, y: 20, width: frame.size.width, height: 1)
        topBorderLayer.backgroundColor = UIColor.lightGray.cgColor
        layer.addSublayer(bottomBorderLayer)
        layer.addSublayer(topBorderLayer)
    }
}
