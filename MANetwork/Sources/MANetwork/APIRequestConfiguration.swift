//
//  APIRequestConfiguration.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 04/08/2024.
//

import Foundation

public
protocol APIRequestConfiguration {
  var method: HTTPMethod { get }
  var path: String { get }
  var queryParams: [String: Any]? { get }
  var parameters: Parameters? { get }
  var headers: HTTPHeaders? { get }
  var files: [UploadMediaFile]? { get }
}

extension APIRequestConfiguration {
  private var baseHeaders: HTTPHeaders {
    let headers = [
      "Content-Type": "application/json",
      "Accept": "application/json",
    ]
    /// If you are using authorized requests don't forget to add -> headers["Authorization"] = YOUR-TOKEN -> from keychain or whatever
    return headers
  }

  public
  func asURLRequest() -> URLRequest {
    /// URL Components
    var components = components
    components.path = "/" + path

    /// Request
    var urlRequest = URLRequest(url: components.url!)
    if path.contains("https://") || path.contains("http://"),
       let url = URL(string: path) {
      urlRequest = URLRequest(url: url)
    }
    urlRequest.httpMethod = method.rawValue

    /// Headers
    /// If you need to add your own headers with the existed basic headers
    let requestHeaders = baseHeaders + headers
    requestHeaders.forEach {
      urlRequest.addValue($1, forHTTPHeaderField: $0)
    }

    /// Parameters you need to pass with the request
    if let parameters = parameters {
      do {
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
      } catch let error {
        print(error)
      }
    }
    return urlRequest
  }

  public
  func asMultipartURLRequest() -> URLRequest {
    var components = components
    components.path = "/" + path

    /// Request
    var urlRequest = URLRequest(url: components.url!)
    if path.contains("https://") || path.contains("http://"),
       let url = URL(string: path) {
      urlRequest = URLRequest(url: url)
    }
    urlRequest.httpMethod = method.rawValue
    if let headers = headers {
      _ = headers.map({
        urlRequest.addValue($0.value, forHTTPHeaderField: "\($0.key)")}
      )
    }
    let boundary = generateBoundary()
    urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    let dataBody = createDataBody(withParameters: parameters ?? [:], media: files, boundary: boundary)
    urlRequest.httpBody = dataBody
    return urlRequest

  }

  private func addQueryItems(queryParams: [String: Any]) -> [URLQueryItem] {
    return queryParams.map({
      URLQueryItem(name: $0.key, value: "\($0.value)")}
    )
  }

  func createDataBody(withParameters parameters: [String: Any], media: [UploadMediaFile]?, boundary: String) -> Data {
    let lineBreak = "\r\n"
    var body = Data()
    for (key, value) in parameters {
      body.append("--\(boundary + lineBreak)")
      body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
      body.append("\((value as? String) ?? "") + lineBreak)")
    }
    if let media = media {
      for photo in media {
        body.append("--\(boundary + lineBreak)")
        body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
        body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
        body.append(photo.data)
        body.append(lineBreak)
      }
    }
    body.append("--\(boundary)--\(lineBreak)")
    return body
  }

  func generateBoundary() -> String {
    return "Boundary-\(NSUUID().uuidString)"
  }

  /// For any URL Components especially if you are using Environment to specific in which Environment you are
  /// so you can change: 1. components.scheme = Assign the scheme you need
  /// 2. components.host = Assign the host you need
  var components: URLComponents {
    let components = URLComponents()
    return components
  }
}

public typealias HTTPHeaders = [String:String]
public typealias Parameters = [String: Any]
