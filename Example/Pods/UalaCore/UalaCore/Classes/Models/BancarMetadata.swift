public struct BancarMetadata {
    public let dict: [String: String]
    
    public init(with metadata: String) {
        self.dict = BancarMetadata.dictFromBancarMetadata(metadata: metadata)
    }
    
    static func dictFromBancarMetadata(metadata: String) -> [String: String] {
        if metadata.count < 3 {
            return [:]
        }
        
        let start = metadata.index(metadata.startIndex, offsetBy: 1)
        let end = metadata.index(metadata.endIndex, offsetBy: -1)
        let range = start..<end
        
        let clearBraceMetadata = metadata.substring(with: range)
        
        let objects: [String] = clearBraceMetadata.components(separatedBy: ",")
        
        var dict: [String:String] = [:]
        
        _ = objects.map {
            if $0.contains("=") {
                dict[$0.components(separatedBy: "=")[0].trimmingCharacters(in: .whitespacesAndNewlines)]
                    = $0.components(separatedBy: "=")[1].trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        
        return dict
    }
}
