
import Foundation

struct HttpManager {
//    static let sharedInstanse:HttpManager = HttpManager()
    
    static var baseUrl = "api.themoviedb.org/3"
    static var apiKey = "bf887a4f799f533b9e5c816ff0fd2089"
    
    //MARK:- private properties
    private static var requests:[MovieRequest] = []
    
    //MARK:- init
    private init(){
        
    }
    
    //MARK:- public methods
    static func createRequest(method:RequestType = .get, protocoll:ProtocolType = .http, baseUrl:String = "", path:String = "", queryParams:[String:PathValue], header:[String:HeaderValue], contentType:RequestContentType, content:DictionaryValue? = nil, token:String? = nil, authType:AthurationType? = nil, delegate:MovieRequestDelegate, keyNameOfValue:String?) ->MovieRequest
    {
        let request = MovieRequest(method: method, protocoll: protocoll, baseUrl: baseUrl, path: path, queryParams: queryParams, header: header, contentType: contentType, content: content, token: token, authType: authType, delegate:delegate, keyNameOfValue: keyNameOfValue)
        return request
    }
    
    static func sendRequest<D:Codable>(request:MovieRequest, responseType:D.Type?){
        self.addRequestToList(request: request)
        request.send(responseType: responseType)
    }
    
    static func sendSucessResponseToDelegate(item:Codable, request:MovieRequest){
        self.removeRequestFromList(request: request)
        request.delegate?.sucessGetData(item: item, request: request)
    }
    
    static func sendFaildResponseToDelegate(error:MovieError, request:MovieRequest){
        self.removeRequestFromList(request: request)
        request.delegate?.faildGetData(error: error, request: request)
    }
    
    //NARK:- private methods
    private static func addRequestToList(request:MovieRequest){
        let existOnRequests = self.requests.contains(where: {$0.id == request.id})
        guard existOnRequests else{
            self.requests.append(request)
            return;
        }
    }
    
    private static func removeRequestFromList(request:MovieRequest){
        self.requests.removeAll(where: {$0.id == request.id})
    }
}

