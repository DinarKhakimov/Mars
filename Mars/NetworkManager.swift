//
//  NetworkManager.swift
//  Mars
//
//  Created by Dinar Khakimov on 22/7/22.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
    
class NetworkManager {
    static var shared = NetworkManager()
    private init() {}
    
    func fetchData(from url: String?, with completion:  @escaping(MarsRoverPhotos) -> Void) {
        guard let url = URL(string: url ?? "" ) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No description")
                return
            }
            do {
                let marsRoverPhotos = try JSONDecoder().decode(MarsRoverPhotos.self, from: data)
                DispatchQueue.main.async {
                    completion(marsRoverPhotos)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    
    func fetchCamera(from url: String, completion: @escaping(Result<Camera,NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No description")
                return
            }
            do {
                let camera = try JSONDecoder().decode(Camera.self, from: data)
                completion(.success(camera))
            } catch {
                completion(.failure(.decodingError))
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchRover(from url: String, completion: @escaping(Result<Rover, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let rover = try JSONDecoder().decode(Rover.self, from: data)
                completion(.success(rover))
            } catch {
                completion(.failure(.decodingError))
                print(error.localizedDescription)
                return
            }
        }.resume()
    }
}

class ImageManager {
    static var shared = ImageManager()
    private init() {}
    
    func fetchImage(from url: String?) -> Data? {
        guard let stringURL = url else { return nil }
        guard let imageURL = URL(string: stringURL) else { return nil }

        return try? Data(contentsOf: imageURL)
    }
}
