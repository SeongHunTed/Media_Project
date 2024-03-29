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
//        addBottomBorder()
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
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .systemGray5
        pageControl.currentPageIndicatorTintColor = .systemGray
        pageControl.isUserInteractionEnabled = false
        pageControl.numberOfPages = 5
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.myFontR.withSize(15.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let digitLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.myFontR.withSize(15.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
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
    
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(pageControl)
        self.addSubview(timeLabel)
        self.addSubview(digitLabel)
        self.addSubview(addressLabel)
        self.addSubview(mapView)
        self.mapView.addSubview(naverMapView)

        NSLayoutConstraint.activate([
            
            pageControl.widthAnchor.constraint(equalToConstant: 200),
            pageControl.heightAnchor.constraint(equalToConstant: 30),
            pageControl.topAnchor.constraint(equalTo: self.topAnchor, constant: -2),
            pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: self.pageControl.bottomAnchor, constant: 30),
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
//        let bottomBorderLayer = CALayer()
//        bottomBorderLayer.frame = CGRect(x: 0, y: frame.size.height - 1, width: frame.size.width, height: 1)
//        bottomBorderLayer.backgroundColor = UIColor.lightGray.cgColor
        let topBorderLayer = CALayer()
        topBorderLayer.frame = CGRect(x: 0, y: 30, width: frame.size.width, height: 1)
        topBorderLayer.backgroundColor = UIColor.lightGray.cgColor
//        layer.addSublayer(bottomBorderLayer)
        layer.addSublayer(topBorderLayer)
    }
    
    func configure(with store: MainStorePopUpRequest, _ lat: Double, _ long: Double) {
        let openTime = store.storeOpenTime.prefix(5)
        let closeTime = store.storeCloseTime.prefix(5)
        timeLabel.text = "⏰ 영업 : 평일 \(openTime) ~ \(closeTime)"
        digitLabel.text = "☎️ \(store.storeDigit)"
        addressLabel.text = "🚗 \(store.storeAddress)"
        
        // Set Store's Marker
        let marker: NMFMarker = {
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: lat, lng: long)
            return marker
        }()
        
        // Map Camera Position
        let cameraUpdate: NMFCameraUpdate = {
            let camera = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: long), zoomTo: 14.5)
            return camera
        }()
        naverMapView.moveCamera(cameraUpdate)
        marker.mapView = naverMapView
    }
}
