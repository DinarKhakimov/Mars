//
//  MarsRoverPhoto.swift
//  Mars
//
//  Created by Dinar Khakimov on 22/7/22.
//

import Foundation

// MARK: - Welcome
struct MarsRoverPhotos: Codable {
    let photos: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let id, sol: Int
    let camera: Camera
    let imgSrc: String
    let earthDate: String
    let rover: Rover

    enum CodingKeys: String, CodingKey {
        case id, sol, camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
}

// MARK: - Camera
struct Camera: Codable {
    let id: Int
    let name: String
    let roverID: Int
    let fullName: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case roverID = "rover_id"
        case fullName = "full_name"
    }
}

// MARK: - Rover
struct Rover: Codable {
    let id: Int
    let name, landingDate, launchDate, status: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
    }
}


enum Link: String {
    case marsRoverPhotApi = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2017-07-3&api_key=5ybPuL4y9ghJbYQrSWGjH0KCvcI1JMKOpH0e5Vtu"
}

