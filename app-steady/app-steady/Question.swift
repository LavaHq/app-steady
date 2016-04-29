class Question : NSObject {
    var text : String = ""

    init(JSONString: String) {
        super.init()
        var error : NSError?
        let JSONData = JSONString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        let JSONDictionary: Dictionary = NSJSONSerialization.JSONObjectWithData(JSONData, options: nil, error: &error) as NSDictionary
    
        self.setValuesForKeysWithDictionary(JSONDictionary)
    }
}
