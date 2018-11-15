//
//  ViewController.swift
//  price_xml_Parsing
//
//  Created by Sang won Seo on 12/11/2018.
//  Copyright © 2018 Sang won Seo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    var item:[String:String] = [:] // currentElement가 모여서 하나의 배열 item
    var elements:[[String:String]] = [] //item의 배열이 모여서 elements
    var currentElement = ""
    let parseKey = "rpHjQEu9lGtZuqi2664U%2B4dAORmvzIgLiBuy%2F%2F4kxrKcU0%2BqSW1Vmd%2FJUoZurDsKC8tnZtyOLw5onrjVqQnuxg%3D%3D"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myTableView.delegate = self
        myTableView.dataSource = self
        let strURL = "http://apis.data.go.kr/B552895/LocalGovPriceInfoService/getItemPriceResearchSearch?serviceKey=\(parseKey)&examin_de=20181104&&numOfRows=300&pageNo=1&examin_area_nm=%EB%B6%80%EC%82%B0"
        print(parseKey)
        if NSURL(string: strURL) != nil {
            if let parser = XMLParser(contentsOf: URL(string: strURL)!) {
                parser.delegate = self
                
                if parser.parse() {
                    print("parsing success")
                    
                    print(elements)
                } else {
                    print("parsing fail")
                }
                
            }
        }
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        print("currentElement = \(elementName)")
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        print("data = \(data)")
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
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "RE", for: indexPath)
        let myItem = elements[indexPath.row]
        let productNm = cell.viewWithTag(1) as! UILabel //prdlst_nm
        let grade = cell.viewWithTag(2) as! UILabel //grad
        let weight = cell.viewWithTag(3) as! UILabel //stndrd
        let distributePrice = cell.viewWithTag(4) as! UILabel //distb_step
        let price = cell.viewWithTag(5) as! UILabel //exmin_amt
        
        productNm.text = myItem["prdlst_nm"]
        grade.text = myItem["grad"]
        weight.text = myItem["stndrd"]
        distributePrice.text = myItem["distb_step"]
        price.text = myItem["examin_amt"]

        
        
        
        return cell
    }

}

