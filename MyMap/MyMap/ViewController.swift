//
//  ViewController.swift
//  MyMap
//
//  Created by 西上　知里 on 2018/08/19.
//  Copyright © 2018年 tsc-343. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController , UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 通知を設定
        inputText.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var dispMap: MKMapView!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        
        // 入力された文字を取り出す
        if let searchKey = textField.text {
            
            // 入力された文字をデバックエリア表示
            print(searchKey)
            
            let geocoder = CLGeocoder()
            
            geocoder.geocodeAddressString(searchKey, completionHandler: { (placemarks, error) in
                
                // 位置情報が存在する場合
                if let unwrapPlacemarks = placemarks {
                    
                    // 1個目の情報を取り出す
                    if let firstPlacemark = unwrapPlacemarks.first {
                        
                        // 位置情報を取り出す
                        if let location = firstPlacemark.location {
                            
                            // 位置情報から緯度経度を取り出す
                            let targetCoordinate = location.coordinate
                            
                            print(targetCoordinate)
                            
                            // ピンを生成
                            let pin = MKPointAnnotation()
                            
                            // ピンの置く場所に緯度経度を設定
                            pin.coordinate = targetCoordinate
                            
                            // ピンのタイトルを設定
                            pin.title = searchKey
                            
                            // ピンを地図に置く
                            self.dispMap.addAnnotation(pin)
                            
                            // 緯度経度を中心にして半径500mの範囲を表示
                            self.dispMap.region = MKCoordinateRegionMakeWithDistance(targetCoordinate, 500.0, 500.0)
                        }
                    }
                }
            })
        }
        
        return true
    }
    
    @IBAction func changeMapButtonAction(_ sender: Any) {
        if dispMap.mapType == .standard {
            dispMap.mapType = .satellite
        } else if dispMap.mapType == .satellite {
            dispMap.mapType = .hybrid
        } else if dispMap.mapType == .hybrid {
            dispMap.mapType = .satelliteFlyover
        } else if dispMap.mapType == .satelliteFlyover {
            dispMap.mapType = .hybridFlyover
        } else {
            dispMap.mapType = .standard
        }
    }
    
}

