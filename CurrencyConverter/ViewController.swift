import UIKit





class ViewController: UIViewController {
    
    let titleLabel = UILabel()
    
    let CADLabel = UILabel()
    let CHFLabel = UILabel()
    let GBPLabel = UILabel()
    let JPYLabel = UILabel()
    let USDLabel = UILabel()
    let TRYLabel = UILabel()
    
    let button = UIButton()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        titleLabel.text = "Currency Converter"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textAlignment = .center
        titleLabel.frame = CGRect(x: 0, y: 100, width: width, height: 50)
        view.addSubview(titleLabel)
        
        CADLabel.text = "CAD:"
        CADLabel.textAlignment = .center
        CADLabel.frame = CGRect(x: 0, y: 225, width: width, height: 25)
        view.addSubview(CADLabel)
        
        CHFLabel.text = "CHF:"
        CHFLabel.textAlignment = .center
        CHFLabel.frame = CGRect(x: 0, y: 300, width: width, height: 25)
        view.addSubview(CHFLabel)
        
        GBPLabel.text = "GBP:"
        GBPLabel.textAlignment = .center
        GBPLabel.frame = CGRect(x: 0, y: 375, width: width, height: 25)
        view.addSubview(GBPLabel)
        
        JPYLabel.text = "JPY:"
        JPYLabel.textAlignment = .center
        JPYLabel.frame = CGRect(x: 0, y: 450, width: width, height: 25)
        view.addSubview(JPYLabel)
        
        USDLabel.text = "USD:"
        USDLabel.textAlignment = .center
        USDLabel.frame = CGRect(x: 0, y: 525, width: width, height: 25)
        view.addSubview(USDLabel)
        
        TRYLabel.text = "TRY:"
        TRYLabel.textAlignment = .center
        TRYLabel.frame = CGRect(x: 0, y: 600, width: width, height: 25)
        view.addSubview(TRYLabel)
        
        button.setTitle("Get Rates", for: UIControl.State.normal)
        button.setTitleColor(UIColor.magenta, for: UIControl.State.normal)
        button.frame = CGRect(x: 0, y: 700, width: width, height: 25)
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(buttonClicked), for: UIControl.Event.touchUpInside)
        
        
        
    }
    
    @objc func buttonClicked() {
        
        //Request & Session
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=09103f7c4389316a2760365182999d8b")
        
        let session = URLSession.shared
        
        //Closure
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else{
                //Response & Data
                if data != nil {
                    
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                        
                        //ASYNC
                        
                        DispatchQueue.main.async {
                            
                            if let rates = jsonResponse["rates"] as? Dictionary<String,Any>{
                                
                                if let cad = rates["CAD"] as? Double{
                                    
                                    self.CADLabel.text = "CAD: \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double{
                                    
                                    self.CHFLabel.text = "CHF: \(chf)"
                                }
                                if let gbp = rates["GBP"] as? Double{
                                    self.GBPLabel.text = "GBP: \(gbp)"
                                }
                                if let jpy = rates["JPY"] as? Double{
                                    self.JPYLabel.text = "JPY: \(jpy)"
                                }
                                if let usd = rates["USD"] as? Double{
                                    self.USDLabel.text = "USD: \(usd)"
                                }
                                if let tryy = rates["TRY"] as? Double{
                                    self.TRYLabel.text = "TRY: \(tryy)"
                                }
                            }
                            
                        }
                        
                        
                    }catch{
                        print("Error")
                    }
                    
                    
                    
                    
                    
                }
            }
        }
        
        task.resume()
        
        
    }
    
    


}

