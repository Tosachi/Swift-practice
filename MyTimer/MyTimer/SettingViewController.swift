//
//  SettingViewController.swift
//  MyTimer
//
//  Created by 西上　知里 on 2018/08/21.
//  Copyright © 2018年 tsc-343. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController , UIPickerViewDataSource , UIPickerViewDelegate {

    // UIPockerViewに表示するデータをArrayで作成
    let settingArray : [Int] = [10, 20, 30, 40, 50, 60]
    
    // 設定値を覚えるキーを設定
    let settingKey = "timer_value"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // timerSettingPickerのデリゲートとデータソースの通知先を設定
        timerSettingPicker.delegate = self
        timerSettingPicker.dataSource = self
        
        // UserDefaultsの取得
        let settings = UserDefaults.standard
        let timerValue = settings.integer(forKey: settingKey)
        
        // Pickerの選択を合わせる
        for row in 0..<settingArray.count {
            if settingArray[row] == timerValue {
                timerSettingPicker.selectRow(row, inComponent: 0, animated: true)
            }
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBOutlet weak var timerSettingPicker: UIPickerView!
    
    
    @IBAction func decisionButtonAction(_ sender: Any) {
        // 前画面に戻る
        _ = navigationController?.popViewController(animated: true)
    }
    
    // 列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return settingArray.count
    }
    
    // 表示する内容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(settingArray[row])
    }
    
    // Picker選択時に実行
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // UserDefaultsの設定
        let settings = UserDefaults.standard
        settings.setValue(settingArray[row], forKey: settingKey)
        settings.synchronize()
    }
    
    

}
