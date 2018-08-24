//
//  ViewController.swift
//  MyMusic
//
//  Created by 西上　知里 on 2018/08/19.
//  Copyright © 2018年 tsc-343. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let cymbalPath = Bundle.main.bundleURL.appendingPathComponent("cymbal.mp3")
    
    var cymbalPlayer = AVAudioPlayer()
    
    @IBAction func cymbal(_ sender: Any) {
        soundPlayer(player: &cymbalPlayer, Path: cymbalPath, count: 0)
    }
    
    let guitarPath = Bundle.main.bundleURL.appendingPathComponent("guitar.mp3")
    
    var guitarPlayer = AVAudioPlayer()
    
    @IBAction func guiter(_ sender: Any) {
        soundPlayer(player: &guitarPlayer, Path: guitarPath, count: 0)
    }
    
    let backmusicPath = Bundle.main.bundleURL.appendingPathComponent("backmusic.mp3")
    
    var backmusicPlayer = AVAudioPlayer()
    
    @IBAction func play(_ sender: Any) {
        soundPlayer(player: &backmusicPlayer, Path: backmusicPath, count: -1)
    }
    
    @IBAction func stop(_ sender: Any) {
        backmusicPlayer.stop()
    }
    
    fileprivate func soundPlayer(player: inout AVAudioPlayer, Path:URL, count:Int){
        do {
            player = try AVAudioPlayer(contentsOf: Path, fileTypeHint: nil)
            player.numberOfLoops = count
            player.play()
        } catch {
            print("catch error")
        }
    }
    
    
}

