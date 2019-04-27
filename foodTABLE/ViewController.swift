//
//  ViewController.swift
//  foodTABLE
//
//  Created by sun on 27/4/2562 BE.
//  Copyright © 2562 sun. All rights reserved.
//

import UIKit

struct foodData:Decodable {
    
    let NameFood:String
    let Price:String
    let ImagePath:String
    
    
}

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrdata.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:foodTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! foodTableViewCell
        
        cell.nameLabel.text = self.arrdata[indexPath.row].NameFood
        cell.priceLabel.text = self.arrdata[indexPath.row].Price
        
        if let imageURL = URL(string: arrdata[indexPath.row].ImagePath) {
            
            DispatchQueue.global().async {
                
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        
                        cell.imageURL.image = image
                        
                    }
                }
            }
            
            
        }else{
            print("ERROR LOAD IMAGE")
        }
        
        return cell
        
    }
    
    
    var arrdata = [foodData]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getdata()
        // Do any additional setup after loading the view.
    }
    
    func getdata() {
        let url = URL(string: "https://www.androidthai.in.th/ssm/getAllDatafoodTABLE.php")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            do{
                
                if error == nil{
                    
                    self.arrdata = try JSONDecoder().decode([foodData].self, from: data!)
                    
                    for mainarr in self.arrdata{
                        print(mainarr.NameFood,":",mainarr.Price,":",mainarr.ImagePath)
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                        
                    }
                    
                }
                
            }catch let myError{
                print(myError)
            }
            
        }.resume()
    }


}

