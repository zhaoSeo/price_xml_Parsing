//
//  CollectionViewController.swift
//  price_xml_Parsing
//
//  Created by Sang won Seo on 11/12/2018.
//  Copyright © 2018 Sang won Seo. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, XMLParserDelegate  {
    
    //Mark : make parsing Data
    var item:[String:String] = [:] // item = [currentData:data + currentData:data + ...]
    var elements:[[String:String]] = [] //element = [item + item + ...]
    var currentElement = ""
    let parseKey = "rpHjQEu9lGtZuqi2664U%2B4dAORmvzIgLiBuy%2F%2F4kxrKcU0%2BqSW1Vmd%2FJUoZurDsKC8tnZtyOLw5onrjVqQnuxg%3D%3D"
    var Data: PriceData? //item + image = Data
    var Datas: Array = [PriceData]() //Datas = [Data + Data + ...]
    var image: String?
    var condition = ""
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
        "얼갈이배추" : "13",
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
        "방울토마토" : "65",
        "닭고기" : "66",
        "계란" : "67",
        "굴" : "68",
        "건오징어" : "69",
        "전복" : "70",
        "새우" : "71",
        "북어" : "72",
        "김" : "73",
        "건미역" : "74",
        "시금치" : "75",
        "감귤" : "76",
        "조기" : "77",
        "새우젓" : "78",
        "멸치액젓" : "79",
        "굵은소금" : "80"
        
    ]
    //Mark : make collectionView Data
    let imgArray = [UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3"),UIImage(named: "4"),UIImage(named: "5"),UIImage(named: "6")]
    let nameArray = ["전체", "곡류", "과일", "생선", "야채", "견과류"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        parse()
        putImageInData()
    }
    // MARK: Parsing Start
    func parse() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let yesterday = NSDate().addingTimeInterval(-24 * 60 * 60 * 1 )
        let theDayBeforeYesterday = NSDate().addingTimeInterval(-24 * 60 * 60 * 2 )
        let theDayThreeDayBefore = NSDate().addingTimeInterval(-24 * 60 * 60 * 3 )
        let theDayFourDayBefore = NSDate().addingTimeInterval(-24 * 60 * 60 * 4 )
        let convertedDate1 = dateFormatter.string(from: yesterday as Date)
        let convertedDate2 = dateFormatter.string(from: theDayBeforeYesterday as Date)
        let convertedDate3 = dateFormatter.string(from: theDayThreeDayBefore as Date)
        let convertedDate4 = dateFormatter.string(from: theDayFourDayBefore as Date)
        let strURL1 = "http://apis.data.go.kr/B552895/LocalGovPriceInfoService/getItemPriceResearchSearch?serviceKey=\(parseKey)&examin_de=\(convertedDate1)&numOfRows=300&pageNo=1&examin_area_nm=%EB%B6%80%EC%82%B0"
        let strURL2 = "http://apis.data.go.kr/B552895/LocalGovPriceInfoService/getItemPriceResearchSearch?serviceKey=\(parseKey)&examin_de=\(convertedDate2)&numOfRows=300&pageNo=1&examin_area_nm=%EB%B6%80%EC%82%B0"
        let strURL3 = "http://apis.data.go.kr/B552895/LocalGovPriceInfoService/getItemPriceResearchSearch?serviceKey=\(parseKey)&examin_de=\(convertedDate3)&numOfRows=300&pageNo=1&examin_area_nm=%EB%B6%80%EC%82%B0"
        let strURL4 = "http://apis.data.go.kr/B552895/LocalGovPriceInfoService/getItemPriceResearchSearch?serviceKey=\(parseKey)&examin_de=\(convertedDate4)&numOfRows=300&pageNo=1&examin_area_nm=%EB%B6%80%EC%82%B0"
        //        print(convertedDate1)
        //        print(convertedDate2)
        //        print(convertedDate3)
        //        print(convertedDate4)
        
        if NSURL(string: strURL1) != nil {
            if let parser = XMLParser(contentsOf: URL(string: strURL1)!) {
                parser.delegate = self
                if parser.parse() {
                    print("parsing success")
                    //                    print(elements)
                } else {
                    print("parsing fail")
                }
            }
        }
        if NSURL(string: strURL2) != nil {
            if let parser = XMLParser(contentsOf: URL(string: strURL2)!) {
                parser.delegate = self
                if parser.parse() {
                    print("parsing success")
                    //                    print(elements)
                } else {
                    print("parsing fail")
                }
            }
        }
        if NSURL(string: strURL3) != nil {
            if let parser = XMLParser(contentsOf: URL(string: strURL3)!) {
                parser.delegate = self
                if parser.parse() {
                    print("parsing success")
                    //                    print(elements)
                } else {
                    print("parsing fail")
                }
            }
        }
        if NSURL(string: strURL4) != nil {
            if let parser = XMLParser(contentsOf: URL(string: strURL4)!) {
                parser.delegate = self
                if parser.parse() {
                    print("parsing success")
                    //                    print(elements)
                } else {
                    print("parsing fail")
                }
            }
        }
    }
    
    // MARK: Parsing
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
            //            print(item)
        }
    }
    // MARK: put Image in Data
    func putImageInData() {
        for item in elements {
            let productNm = item["prdlst_nm"]
            //            print("prdlst_nm = \(String(describing: productNm))")
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
            let examinDay = item["examin_de"]
            //            print("prdlstDetailNm = \(String(describing: prdlstDetailNm))")
            //            print("grad = \(String(describing: grade))")
            //            print("stndrd = \(String(describing: weight))")
            //            print("distb_step = \(String(describing: distributePrice))")
            //            print("prdlst_nm = \(String(describing: price))")
            //            print("examin_de = \(String(describing: examinDay))")
            Data =
                PriceData(productNm: productNm!, prdlstDetailNm: prdlstDetailNm!, grade: grade!, weight: weight!, distributePrice: distributePrice!, price: price!, image: image!, examinDay: examinDay!)
            //            print("Data = \(String(describing: Data))")
            Datas.append(Data!)
        }
    }
    
    //Mark : make collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        cell.myImageView.image = imgArray[indexPath.row]
        cell.imgName.text! = nameArray[indexPath.row]
        
        return cell
    }
    //Mark : pass over to DetailViewController
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desVC = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        desVC.PassingOverDatas = Datas
        desVC.name = nameArray[indexPath.row]
        self.navigationController?.pushViewController(desVC, animated: true)
        
    }
}
