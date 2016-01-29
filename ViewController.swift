//
//  AppDelegate.swift
//  TomCat
//
//  Created by 董兴斌 on 16/1/30.
//  Copyright © 2016年 董兴斌. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var Tom: UIImageView!
    var audioPlayer : AVAudioPlayer!
    var resourceDic : NSDictionary!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = NSBundle.mainBundle().pathForResource("tom", ofType: "plist");
        self.resourceDic = NSDictionary.init(contentsOfFile: path!)
        initView("yawn")
    }
    
    @IBAction func tomTouched(sender: AnyObject)
    {
        let button = sender as! UIButton;
        if self.Tom.isAnimating(){
            return ;
        }
        
        let key =  button.titleForState(UIControlState.Normal)!
        
        initView(key)
        
    }
    
    
    
    func clearMemory(){
        
        
    
        self.Tom.animationImages = nil;
    }
    
    
    
    func playWithAudioName(audioName : String){
        
        let path = NSBundle.mainBundle().pathForResource(audioName, ofType: "wav")
        
        if path == nil{
            
            print("W没有同名的音频资源")
            print("path: %@",path)
            
            return
        }
        if path == "pie"
        {
            sleep(1)
            
        }

        
        
        let playUrl = NSURL.init(fileURLWithPath: path!)
        
        do{
            print(path)
            
            try audioPlayer = AVAudioPlayer(contentsOfURL: playUrl)
            audioPlayer.numberOfLoops = 0;
            audioPlayer .play()
           
            
        }catch let error as NSError{
            
            print(error.description)
        }
    }
    
    func initView(key: String){
        //        if key == "drink"
        //        {
        //
        //            //1.加载图片到数组中
        //            var imgArray = [UIImage]();
        //            for var i = 0; i<1; ++i{
        //                //let imgName = i<0 ? "drink\(i)" : "drink\(i)";
        //                let image:UIImage = UIImage(named: "drink")!;
        //                imgArray.insert(image, atIndex: i);
        //            }
        //            //2.将数组添加到UIImageView中
        //            self.Tom.animationImages = imgArray;
        //            //3.设置动画持续时间
        //            self.Tom.animationDuration = Double(imgArray.count) * 0.1;
        //            //4.设置动画持续次数
        //            self.Tom.animationRepeatCount = 1;
        //            //5.开启动画
        //            self.Tom.startAnimating();
        //
        //        }
        //        else
        //        {
        
        let count = self.resourceDic.objectForKey(key)!.integerValue!
        let imagesArray = NSMutableArray()
        for index in 1..<count{
            let imageName = key + "_" + String.init(format: "%02d", index)
            let imagePath = NSBundle.mainBundle().pathForResource(imageName, ofType: "jpg")!
            let imageTom = UIImage.init(contentsOfFile: imagePath)
            imagesArray.addObject(imageTom!)
        }
        
        let timmer = 0.075;
        
        self.Tom.animationImages = NSArray.init(array: imagesArray) as? [UIImage]
        
        self.Tom.animationDuration = Double(count) * timmer
        
        self.Tom.animationRepeatCount = 1
        
        self.Tom.startAnimating()
        
        self.performSelector("clearMemory", withObject: nil , afterDelay: Double(count) * timmer)
        //MARK: 音频命名有问题
        // }
        NSLog("key: %@", key)
        
        self.playWithAudioName(key)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}