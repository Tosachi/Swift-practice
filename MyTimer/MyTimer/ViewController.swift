//
//  ViewController.swift
//  MyTimer
//
//  Created by 西上　知里 on 2018/08/21.
//  Copyright © 2018年 tsc-343. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // タイマーの変数を作成
    var timer: Timer?
    
    // カウントの変数を作成
    var count = 0
    
    // 設定を行うキーを設定
    let settingKey = "timer_value"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // UserDefaultsのインスタンスを作成
        let settings = UserDefaults.standard
        // userDefaultsに初期値を登録
        settings.register(defaults: [settingKey : 10])

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var countDownLabel: UILabel!
    
    @IBAction func settingButtonAction(_ sender: Any) {
        checkTimerAndStop(timer: timer)
        
        // 画面遷移を行う
        performSegue(withIdentifier: "goSetting", sender: nil)
    }
    
    @IBAction func startButtonAction(_ sender: Any) {
        // timerをアンラップしてnowTimerに代入
        if let nowTmer = timer {
            // もしタイマーが実行中だったらスタートしない
            if nowTmer.isValid == true {
                // 何もしない
                return
            }
        }
        
        // タイマーをスタート
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(self.timerInterrupt(_:)),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @IBAction func stopButtonAction(_ sender: Any) {
        checkTimerAndStop(timer: timer)
    }
    
    // タイマーが実行中だったら止める処理
    fileprivate func checkTimerAndStop(timer: Timer?) {
        // timerをアンラップしてnowTimerに代入
        if let nowTimer = timer {
            // もしタイマーが実行中だったら停止
            if nowTimer.isValid == true {
                // タイマー停止
                nowTimer.invalidate()
            }
        }

    }
    
    // 画面の更新をする（戻り値は残り時間）
    func DisplayUpdate() -> Int {
        // UserDefaultsのインスタンスを生成
        let settings = UserDefaults.standard
        // 取得した秒数をtimerValueに渡す
        let timerValue = settings.integer(forKey: settingKey)
        // 残り時間を生成
        let remainCount = timerValue - count
        // remainCountをラベルに表示
        countDownLabel.text = "残り\(remainCount)秒"
        // 残り時間を戻り値に設定
        return remainCount
    }
    
    @objc func timerInterrupt(_ timer:Timer) {
        // 経過時間に+1していく
        count += 1
        
        // remainCounterga0以下の時タイマーを止める
        if DisplayUpdate() <= 0 {
            // 初期化処理
            count = 0
            // タイマーを停止
            timer.invalidate()
            
            let alertController = UIAlertController(title: "終了", message: "タイマー終了時間です", preferredStyle: .alert)
            // ダイアログに表示させるOKボタンの作成
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            // アクションを追加
            alertController.addAction(defaultAction)
            // ダイアログの表示
            present(alertController, animated: true, completion: nil)
        }
    }
    
    // 画面切り替えのタイミングで処理を行う
    override func viewDidAppear(_ animated: Bool) {
        // カウントを0にする
        count = 0
        // タイマーの表示を更新する
        _ = DisplayUpdate()
    }
    
    
}

