import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let array : [String] = ["60", "75", "90", "105", "120"] //1.0 0.5
    var bpmContainer : String = ""
    var bpm : Double = 0
    var imgNames : [String] = ["dance1", "dance2"]

    @IBOutlet weak var metroPicker: UIPickerView!
    let soundPath = Bundle.main.bundleURL.appendingPathComponent("button46.mp3")
    var soundPlayer = AVAudioPlayer()
    
//    列
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
//    行
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
    }
//    行の表示
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        bpmContainer = array[row]
        switch bpmContainer {
        case "60":
            bpm = 1.0
        case "75":
            bpm = 0.875
        case "90":
            bpm = 0.75
        case "105":
            bpm = 0.625
        case "120":
            bpm = 0.5
        default:
            print("bpmエラー")
        }
        return String(array[row] + "bpm")
    }
    
    var timer : Timer?
    var timeInterval : Double = 0.0
    
    @IBOutlet weak var label1: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        metroPicker.delegate = self
        metroPicker.dataSource = self
        bpm = 1
        label1.image = UIImage(named: "dance1")
    }
    
    func metroSound(){
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: soundPath, fileTypeHint: nil)
            soundPlayer.play()
        } catch {
            print("サウンドエラー")
        }
        
    }
    
    @objc func metro(_ timer:Timer){
        if label1.image == UIImage(named: "dance1"){
            label1.image = UIImage(named: "dance2")
            metroSound()
        } else {
            label1.image = UIImage(named: "dance1")
            metroSound()
        }
        
    }
    
    
    @IBAction func startButton(_ sender: Any) {
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                return
            }
        }
        timer = Timer.scheduledTimer(timeInterval: bpm,
                                     target: self,
                                     selector: #selector(self.metro(_:)),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @IBAction func stopButton(_ sender: Any) {
        if let nowTimer = timer {
        if nowTimer.isValid == true {
            nowTimer.invalidate()
        }
      }
    }
    
}
