//
//  ViewController.swift
//  MyCamera
//
//  Created by 西上　知里 on 2018/08/22.
//  Copyright © 2018年 tsc-343. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate , UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var pictureImage: UIImageView!
    
    @IBAction func cameraButtonAction(_ sender: Any) {
        // カメラかフォトライブラリーかどちらから画像を取得するか選択
        let alertController = UIAlertController(title: "確認", message: "選択してください", preferredStyle: .actionSheet)
        
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // カメラを使用するための選択肢を定義
            let cameraAction = UIAlertAction(title: "カメラ", style: .default, handler: { (action:UIAlertAction) in
                // カメラを起動
                let imagePickerController : UIImagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .camera
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
                
            })
            alertController.addAction(cameraAction)
        }
        
        // フォトライブラリーが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // フォトライブラリーを利用するための選択肢を定義
            let photoLibraryAction = UIAlertAction(title: "フォトライブラリー", style: .default, handler: {(action : UIAlertAction) in
            // フォトライブラリーを起動
            let imagePickerContoroller : UIImagePickerController = UIImagePickerController()
            imagePickerContoroller.sourceType = .photoLibrary
            imagePickerContoroller.delegate = self
            self.present(imagePickerContoroller, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        
        // キャンセルの選択肢を定義
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // iPadで落ちてしまう対策
        alertController.popoverPresentationController?.sourceView = view
        
        // 選択肢を画面に表示
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func SNSButtonAction(_ sender: Any) {
        // 表示画面をアンラップしてシェア画像として取り出し
        if let shareImage = pictureImage.image {
            // UIActivityControllerに渡す配列を用意
            let shareItem = [shareImage]
            
            // UIActivityViewControllerにシェア画像を渡す
            let controller = UIActivityViewController(activityItems: shareItem, applicationActivities: nil)
            
            // iPadで落ちてしまう対策
            controller.popoverPresentationController?.sourceView = view
            
            // UIActivityViewControllerを表示
            present(controller, animated: true, completion: nil)
        }
    }
    
    // 撮影が終わった時に呼ばれるdelegateメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // 撮影した写真を配置したpictureImageに渡す
        captureImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        // モーダブルビューを閉じる
        dismiss(animated: true, completion: {
            // エフェクト画面に遷移
            self.performSegue(withIdentifier: "showEffectiveView", sender: nil)
        })
    }
    
    // 次の画面背にするときに渡す画像を格納する場所
    var captureImage : UIImage?
    
    override func prepare(for segue : UIStoryboardSegue, sender : Any?) {
        // 次の画面のインスタンスを格納
        if let nextViewController = segue.destination as? EffectViewController {
            // 次の画面のインスタンスに取得した画像を渡す
            nextViewController.originalImage = captureImage
        }
    }
    
}

