//
//  DataProvider.swift
//  Lobe_iOS
//
//  Created by Elliot Boschwitz on 10/11/20.
//  Copyright © 2020 Adam Menges. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Network singleton layer.
class DataProvider {
    
    static let shared = DataProvider()
    
    // TO-DO: determine URL automatically
    private let LOBE_ROOT_URL = "http://192.168.0.129:3001"
    private let API_PATH_PROJECT = "/data/v1/project"
    
    public var projectdata: [String:Project] = [:]

    
    // MARK: - DataProviderError enum.
    enum DataProviderError: String, Error {
        case missingUrl = "Error: no URL found."
        case requestFailed = "Error: API call failed."
        case missingData = "Error: no data found."
        case jsonDecodeError = "Error: JSON couldn't be decoded for network call."
        case noHotScoreError = "Error: no hot score was determined."
        case noDatetimeError = "Error: no datetime was determined."
        case uknownDataProcessingError = "Error: occured either with JSON decode or sort." // THIS SHOULDN'T HAPPEN
    }
    
    // MARK: - API to get all projects.
    public func getProjectList(success: (([String]) -> Void)? = nil, fail: ((DataProviderError) -> Void)? = nil)  {
        let urlString = "\(LOBE_ROOT_URL)\(API_PATH_PROJECT)"
        guard let urlRequest = URL(string: urlString) else {
            fail?(DataProviderError.missingUrl)
            return
        }
        makeRequest(urlRequest: urlRequest, responseType: [String].self, success: success, fail: fail)
    }
    
    // MARK: - API to get specific project data.
    public func getProjectData(for projectId: String, success: ((Project) -> Void)? = nil, fail: ((DataProviderError) -> Void)? = nil) {
        let urlString = "\(LOBE_ROOT_URL)\(API_PATH_PROJECT)/\(projectId)"
        guard let urlRequest = URL(string: urlString) else {
            fail?(DataProviderError.missingUrl)
            return
        }
        makeRequest(urlRequest: urlRequest, responseType: Project.self, success: success, fail: fail)
    }
    
    // MARK: - Request call.
    private func makeRequest<T: Decodable>(urlRequest: URL, responseType: T.Type, success: ((T) -> Void)? = nil, fail: ((DataProviderError) -> Void)? = nil) {
        let task = URLSession(configuration: .default).dataTask(with: urlRequest) { (data, response, error) in
            // make sure no error was returned
            guard error == nil else {
                print(error!)
                fail?(DataProviderError.requestFailed)
                return
            }
            // make sure we got valid response data
            guard let responseData: Data = data else {
                fail?(DataProviderError.missingData)
                return
            }
            
            do {
                let responseProjects = try self.parseJSON(for: responseData, responseType: responseType)
                success?(responseProjects)
            } catch {
                guard let dataProviderError = error as? DataProviderError else {
                    fail?(DataProviderError.uknownDataProcessingError)
                    return
                }
                print("Request failed for: \(urlRequest)")
                fail?(dataProviderError)
            }
        }
        task.resume()
    }
    
    // MARK: - Parses JSON given projects data.
    private func parseJSON<T: Decodable>(for responseData: Data, responseType: T.Type) throws -> T {
        let decoder = JSONDecoder()
        do {
            let projects = try decoder.decode(responseType, from: responseData)
            return projects
        } catch {
            print(error)
            throw DataProviderError.jsonDecodeError
        }
    }
}
