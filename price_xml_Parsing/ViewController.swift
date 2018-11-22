//
//  ViewController.swift
//  price_xml_Parsing
//
//  Created by Sang won Seo on 12/11/2018.
//  Copyright © 2018 Sang won Seo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myTableView: UITableView!
    var item:[String:String] = [:] // currentElement가 모여서 하나의 배열 item
    var elements:[[String:String]] = [] //item의 배열이 모여서 elements
    var currentElement = ""
    let parseKey = "rpHjQEu9lGtZuqi2664U%2B4dAORmvzIgLiBuy%2F%2F4kxrKcU0%2BqSW1Vmd%2FJUoZurDsKC8tnZtyOLw5onrjVqQnuxg%3D%3D"
    var examin_de = ""
    var Data: PriceData?
    var Datas: Array = [PriceData]()
    var filteredData: Array = [PriceData]()
    var image: String?
    let subject:[String:String] = [
        "쌀" : "01",
        "찹쌀" : "02",
        "콩" : "03",
        "팥(적두)" : "04",
        "녹두" : "05",
        "메밀" : "06",
        "고구마(밤)" : "07",
        "감자" : "08",
        "배추" : "09",
        "양배추" : "10",
        "상추" : "11",
        "얼갈이배추" : "12",
        "수박" : "14",
        "오이" : "15",
        "호박" : "16",
        "토마토" : "18",
        "무" : "19",
        "당근" : "20",
        "열무" : "21",
        "건고추" : "22",
        "풋고추" : "24",
        "붉은고추" : "26",
        "마늘" : "27",
        "양파" : "28",
        "파" : "29",
        "생강" : "31",
        "고춧가루" : "32",
        "깻잎" : "33",
        "피망" : "34",
        "파프리카" : "35",
        "멜론" : "36",
        "참깨" : "37",
        "들깨" : "38",
        "땅콩" : "39",
        "느타리버섯" : "40",
        "팽이버섯" : "41",
        "새송이버섯" : "42",
        "호두" : "43",
        "아몬드" : "44",
        "사과" : "45",
        "배" : "46",
        "포도" : "47",
        "단감" : "48",
        "바나나" : "49",
        "참다래" : "50",
        "파인애플" : "51",
        "레몬" : "52",
        "건포도" : "53",
        "건블루베리" : "54",
        "망고" : "55",
        "쇠고기" : "56",
        "우유" : "57",
        "고등어" : "58",
        "명태" : "59",
        "물오징어" : "60",
        "건멸치" : "61",
        "갈치" : "63",
        "미나리" : "64",
        "방울토마토" : "65"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myTableView.delegate = self
        myTableView.dataSource = self
        let strURL = "http://apis.data.go.kr/B552895/LocalGovPriceInfoService/getItemPriceResearchSearch?serviceKey=\(parseKey)&examin_de=20181104&&numOfRows=300&pageNo=1&examin_area_nm=%EB%B6%80%EC%82%B0"
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        if NSURL(string: strURL) != nil {
            if let parser = XMLParser(contentsOf: URL(string: strURL)!) {
                parser.delegate = self
                
                if parser.parse() {
                    print("parsing success")
                    
//                    print(elements)
                } else {
                    print("parsing fail")
                }
                
            }
        }
        for item in elements {
            let productNm = item["prdlst_nm"]
            print("prdlst_nm = \(String(describing: productNm))")
            // 추가 데이터 처리 addrs주소
            for (key, value) in subject {
                if key == productNm {
                    image = value
                }
            }
            let prdlstDetailNm = item["prdlst_detail_nm"]
            let grade = item["grad"]
            let weight = item["stndrd"]
            let distributePrice = item["distb_step"]
            let price = item["examin_amt"]
             print("prdlstDetailNm = \(String(describing: prdlstDetailNm))")
             print("grad = \(String(describing: grade))")
             print("stndrd = \(String(describing: weight))")
             print("distb_step = \(String(describing: distributePrice))")
             print("prdlst_nm = \(String(describing: price))")
            Data =
                PriceData(productNm: productNm!, prdlstDetailNm: prdlstDetailNm!, grade: grade!, weight: weight!, distributePrice: distributePrice!, price: price!, image: image!)
            print("Data = \(String(describing: Data))")
            Datas.append(Data!)
        }
        print("Datas = \(Datas)")
        filteredData = Datas
    }
//    func setUp() {
//        filteredData = elements
//    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
//        print("currentElement = \(elementName)")
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
//        print("data = \(data)")
        if !data.isEmpty {
            item[currentElement] = data
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            elements.append(item)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return filteredData.count
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = Datas.filter({ Datas -> Bool in
            switch searchBar.selectedScopeButtonIndex {
            case 0:
                if searchText.isEmpty { return true }
                return Datas.productNm.lowercased().contains(searchText.lowercased())
                || Datas.prdlstDetailNm.lowercased().contains(searchText.lowercased())
                || Datas.grade.lowercased().contains(searchText.lowercased())
            default:
                return false
            }
        })
        myTableView.reloadData()
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
        cell.PriceCellImage.image = UIImage(named: filteredData[indexPath.row].image)
        
        
        return cell
    }

}

