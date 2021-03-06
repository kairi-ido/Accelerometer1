//
//  GameViewController.swift
//  Accelerometer
//
//  Created by 井戸海里 on 2020/09/12.
//  Copyright © 2020 IdoUmi. All rights reserved.
//

import UIKit
import CoreMotion

class GameViewController: UIViewController {
    //あわの宣言
    @IBOutlet private weak var awaImageView : UIImageView!
    let motionManager = CMMotionManager()
    var accelerationX: Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        //加速度計が使用できる状態かどうかを判別する
        if motionManager.isAccelerometerAvailable {
            //加速度の取得間隔を設定する
            motionManager.accelerometerUpdateInterval = 0.01
            //加速度計が更新された時に呼ばれる関数
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: {(data,error) in
                //現在の加速度を取得し、その値に基づきawaImageViewの座標を更新する
                self.accelerationX = (data?.acceleration.x)!
                self.awaImageView.center.x =
                    self.awaImageView.center.x - CGFloat(self.accelerationX!*20)
            
            
                //awaImageViewが水平器からはみ出してはいけないため、X座標の限界を設定する
                if self.awaImageView.frame.origin.x < 5 {
                    self.awaImageView.frame.origin.x = 5
                }
                if self.awaImageView.frame.origin.x > 230 {
                    self.awaImageView.frame.origin.x = 230
                }
            })
        }

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultViewController:ResultViewController = segue.destination as! ResultViewController
        resultViewController.accelerationX = self.accelerationX
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
