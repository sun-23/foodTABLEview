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
    let Detail:String
    
}

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrdata.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:foodTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! foodTableViewCell
        
        //nameLabel , priceLabel , imageURL อ้างอิงจาก foodTableViewCell
        cell.nameLabel.text = self.arrdata[indexPath.row].NameFood
        cell.priceLabel.text = self.arrdata[indexPath.row].Price
        
        //แสดงภาพจาก url
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
    
    
    
    
    
    
   
    // show Detail
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fooddetail:DetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "detail"/* ต้องตรงกับ identity storyboard id คือ detail แล้วต้อง tick ที่ use storyboard id */) as! DetailViewController
        
        // detail เป็น string ที่สร้างใน DetailViewContriller.swift เพื่อที่จะเรียกใช้ label ที่ชื่อว่า DetailLabel
        fooddetail.detail = "Detail is \(arrdata[indexPath.row].Detail)"
        
        self.navigationController?.pushViewController(fooddetail, animated: true)
        
    }
    
    
    
    
    
    
    
    
    var arrdata = [foodData]() //สร้างตัวแปร array เอาข้อมูลจาก struct foodData

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
                    
                    self.arrdata = try JSONDecoder().decode([foodData].self, from: data!) // เอาข้อมูลใส่ใน struct foodData
                    
                    for mainarr in self.arrdata{
                        print(mainarr.NameFood,":",mainarr.Price,":",mainarr.ImagePath,":",mainarr.Detail)
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData() // reloadData of tableView
                        }
                        
                        
                    }
                    
                }
                
            }catch let myError{
                print(myError)
            }
            
        }.resume()
    }

    
    
    

}

