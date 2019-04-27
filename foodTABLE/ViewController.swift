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

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.foodSearch.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:foodTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! foodTableViewCell
        
        //nameLabel , priceLabel , imageURL อ้างอิงจาก foodTableViewCell
        cell.nameLabel.text = self.foodSearch[indexPath.row].NameFood
        cell.priceLabel.text = self.foodSearch[indexPath.row].Price
        
        /*แ สดงภาพจาก url แต่ถ้าภาพไม่ขึ้นต้องไป อณุญาติ domain ดูวิธีทำจาก https://www.androidthai.in.th/article-ios-swift/249-security-setting-ios-connected-http.html */
        if let imageURL = URL(string: foodSearch[indexPath.row].ImagePath) {
            
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
        fooddetail.detail = "Detail is \(foodSearch[indexPath.row].Detail)"
        
           if let imageURL = URL(string: foodSearch[indexPath.row].ImagePath) {
            
            DispatchQueue.global().async {
                
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        
                        // DetailImage is Declared In DetailViewController.swift
                        fooddetail.DetailImage.image = image 
                        
                    }
                }
            }
            
            
        }else{
            print("ERROR LOAD IMAGE")
        }
        
        self.navigationController?.pushViewController(fooddetail, animated: true)
        
    }
    
    
    
    
    
    
    
    
    var arrdata = [foodData]() //สร้างตัวแปร array เอาข้อมูลจาก struct foodData
    var foodSearch = [foodData]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getdata()
        setUp()
    }
    
    
    
    
    
    
    
    
    
    private func setUp() {

        foodSearch = arrdata // เนื่องจาก searchBar ต้องใช้ตัวแปรอีกตัวอ้างอิงค่าจาก struct foodData ถึงจะทำงานได้
        
    }
    
  
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        foodSearch = arrdata.filter({ data -> Bool in
            switch searchBar.selectedScopeButtonIndex {
            case 0:
                if searchText.isEmpty { return true }
                return data.NameFood.lowercased().contains(searchText.lowercased())
            default:
                return false
            }
        })
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
             foodSearch = arrdata
        default:
            break
        }
        tableView.reloadData()
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

