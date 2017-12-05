## What is it?
Packer is a networking library that makes your requests "plug and play". Easy!

## Installing

#### Carthage
github "stone-payments/packer"

## Usage

#### Requests
Every request that one specific API has will need to be represented by a class/struct that implements the `APIRequest` protocol. It will require to specific a `typealias` for Response indicating what is expected to be the response for this request. You will also need to implement a property `resourceName` containing the endpoint for this request in the API. It's good to use a read-only computed property for this so that the `Codable` will not consider this property in the serialization.

The Response's type must implement the `Decodable` protocol. And any property in the request tree must implement the `Encodable` protocol.

###### Request example:
```swift
struct FooRequest: APIRequest {
    // this is the type of the response for this request
    typealias Response = FooResponse

    // the string containing the endpoing should be a computed property
    var resourceName: String {
        return "fooEndpoint"
    }

    var foo: String
    var bar: Int
}
```
###### Response example:
```swift
struct FooResponse: Decodable {
    var status: Bool
    var message: String
}
```

###### What if I have a GET request that does not use query string?

```swift
struct FooRequest: APIRequest {
    typealias Response = FooResponse

    // build the URL using the ID property
    var resourceName: String {
        return "foo/\(fooId)"
    }

    // then make the property for the ID private so it will be ignored in the serialization
    private var fooId: String
}
```

#### APIs
For each API you consume in your app you will need to implement the protocol `APIClient`.
Initialize the `baseUrl` property with a string having the base URL for the API. The property `session` must be a `URLSession` and the `dataTask` a `URLSessionDataTask`. And finally, implement the function `send`.

```swift
class FooAPI: APIClient {
    // we initialize with a default configuration
    var session = URLSession(configuration: .default)
    // here we only declare it
    var dataTask: URLSessionDataTask?
    // the base URL for the API
    var baseUrl = "https://www.foobar.com/v1/"
    var headers: [String : String] = ["Authorization":"API-TOKEN"]

    // this is how we implement the 'send' function for this example API
    func send<T>(_ request: T, method: HTTPMethod, completion: @escaping (Result<T.Response>) -> Void) where T : APIRequest {
        do {
            let urlRequest = try method.urlRequest(urlString: baseUrl, request: request, headers: headers)
            dataTask = session.dataTask(with: urlRequest) { data, response, error in
                if let data = data {
                    do {
                        if let response = response as? HTTPURLResponse,
                            (200...204).contains(response.statusCode) { // specify this according to the API

                            let objectResponse = try JSONDecoder().decode(T.Response.self, from: data)
                            completion(.success(objectResponse))
                        }
                        else { // we are considering everything that's not 200 as an error
                            completion(.failure(APIError.server(errors: ["Error"], message: "API error.")))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                }
                else if let error = error {
                    completion(.failure(error))
                }
                else {
                    completion(.failure(APIError.server(errors: ["Error"], message: nil)))
                }
            }
            dataTask?.resume()
        }
        catch {
            completion(.failure(error))
        }
    }
}
```
> Note that the HTTPMethod is an Enum and has a function called `urlRequest` that can be used to build the `URLRequest` that will be used in the `DataTask`.

#### Using the API client

###### Sending a FooRequest as POST
```swift
let fooRequest = FooRequest(foo: "Test", bar: 42)
let fooClient = FooAPI()
fooClient.send(fooRequest, method: .post) { result in
    switch result {
    case .success(let response):
        print(response.message)
    case .failure(let error):
        print(error)
    }
}
```
