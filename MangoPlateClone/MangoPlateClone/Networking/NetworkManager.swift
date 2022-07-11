import Alamofire
import SwiftyJSON

struct MainInput: Encodable {
    var area: String?
}

class NetworkManager {

    static let shared = NetworkManager()
    var dataSource: [Item] = []

    func getData(viewController: MainViewController) {

        let url = Constant.BASE_URL + "6260000/FoodService/getFoodKr"
        let header: HTTPHeaders = ["serviceKey": Constant.CLIENT_ID]
//
        let queryParam = ["pageNo" : "1",
                          "numOfRows" : "10" ,
                          "resultType" : "json",
                          "UC_SEQ" : "70",
                          "serviceKey": Constant.CLIENT_ID
                        ]

//
        AF.request(url, method: .get, parameters: queryParam, headers: header).validate(statusCode: 200..<300).responseJSON(completionHandler: { response in
            switch response.result {

            case.success(let obj):
                debugPrint(response)
                do {
                    let dataJSON = try
                    JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                    let urlList = try
                    JSONDecoder().decode(GetFoodKr.self, from:dataJSON)

                    self.dataSource = urlList.item

                    DispatchQueue.main.async {
                        viewController.collectionView.reloadData()
                    }
                }  catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }

//                catch {
//                        print(error)
//                    }
//
            case .failure(let e):
                print(e)
            }

        })
    }

}
