//
//  ViewController.swift
//  price_xml_Parsing
//
//  Created by Sang won Seo on 12/11/2018.
//  Copyright © 2018 Sang won Seo. All rights reserved.
//
//
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myTableView: UITableView!
   
    var filteredData: Array = [PriceData]()
    var PassingOverDatas: Array = [PriceData]()
    var name = ""
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myTableView.delegate = self
        myTableView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        self.title = "부산농산물가격정보"
//        print("Datas = \(Datas)")
        filteredData = PassingOverDatas

        print(name)
        filteredData = PassingOverDatas.filter({ Datas -> Bool in
            switch searchBar.selectedScopeButtonIndex {
            case 0:
        if name == "전체" {
            return true
        } else if name == "곡류" {
            return Datas.productNm.lowercased().contains("쌀")
        } else if name == "과일" {
            return Datas.productNm.lowercased().contains("귤")
        } else if name == "생선" {
            return Datas.productNm.lowercased().contains("고등어")
        } else if name == "야채" {
            return Datas.productNm.lowercased().contains("배추")
        } else if name == "견과류" {
            return Datas.productNm.lowercased().contains("땅콩")
        }
            return true
            default:
                return false
            }
        })
         myTableView.reloadData()
    }
 
    // MARK: tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myTableView.dequeueReusableCell(withIdentifier: "RE", for: indexPath)
            as? PriceTableViewCell else {
                return UITableViewCell()
        }
//        let myItem = elements[indexPath.row]
//        let productNm = cell.viewWithTag(1) as! UILabel //prdlst_nm
//        let prdlstDetailNm = cell.viewWithTag(2) as! UILabel
//        let grade = cell.viewWithTag(3) as! UILabel //grad
//        let weight = cell.viewWithTag(4) as! UILabel //stndrd
//        let distributePrice = cell.viewWithTag(5) as! UILabel //distb_step
//        let price = cell.viewWithTag(6) as! UILabel //exmin_amt
//
//        productNm.text = myItem["prdlst_nm"]
//        prdlstDetailNm.text = myItem["prdlst_detail_nm"]
//        grade.text = myItem["grad"]
//        weight.text = myItem["stndrd"]
//        distributePrice.text = myItem["distb_step"]
//        price.text = myItem["examin_amt"]
        
        
        cell.productNm.text = filteredData[indexPath.row].productNm
        cell.prdlstDetailNm.text = filteredData[indexPath.row].prdlstDetailNm
        cell.grade.text = filteredData[indexPath.row].grade
        cell.weight.text = filteredData[indexPath.row].weight
        cell.distributePrice.text = filteredData[indexPath.row].distributePrice
        cell.price.text = filteredData[indexPath.row].price
        cell.examinDay.text = filteredData[indexPath.row].examinDay
        cell.PriceCellImage.image = UIImage(named: filteredData[indexPath.row].image)
        
        
        return cell
    }
    // MARK: Search
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = PassingOverDatas.filter({ Datas -> Bool in
            switch searchBar.selectedScopeButtonIndex {
            case 0:
                if searchText.isEmpty && name == "전체" {
                    return true
                }
                return Datas.productNm.lowercased().contains(searchText.lowercased())
                    || Datas.prdlstDetailNm.lowercased().contains(searchText.lowercased())
                    || Datas.grade.lowercased().contains(searchText.lowercased())
                    || Datas.distributePrice.lowercased().contains(searchText.lowercased())
                
            default:
                return false
            }
        })
        myTableView.reloadData()
    }

}

