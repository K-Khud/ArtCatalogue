//
//  NetworkService.swift
//  ArtCatalogue
//
//  Created by Ekaterina Khudzhamkulova on 16.3.2022.
//

import Foundation
import Networking

final class NetworkService {
    @discardableResult
    func getArtworks(page: Int, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue, completion: @escaping ((_ data: ResponseArtworks?, _ error: Error?) -> Void)) -> RequestTask {
        return ArtEndpointsAPI.getArtworks(page: page, apiResponseQueue: apiResponseQueue, completion: completion)
    }
    @discardableResult
    func getArtists(page: Int, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue, completion: @escaping ((_ data: ResponseArtists?, _ error: Error?) -> Void)) -> RequestTask {
        return ArtEndpointsAPI.getArtists(page: page, apiResponseQueue: apiResponseQueue, completion: completion)
    }
    @discardableResult
    func getImage(imageId: String, iiifUrl: String, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue, completion: @escaping ((_ data: Data?, _ error: Error?) -> Void)) -> RequestTask {
        return ArtEndpointsAPI.getImage(imageId: imageId, iiifUrl: iiifUrl, apiResponseQueue: apiResponseQueue, completion: completion)
    }
}
