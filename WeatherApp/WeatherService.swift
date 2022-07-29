//
//  WeatherService.swift
//  SwiftUI-Weather
//
//  Created by Petr Bouma on 29.07.2022.
//

import CoreLocation
import Foundation

public final class WeatherService: NSObject {
    
    private let locationManager = CLLocationManager()
    private let API_KEY = "2de7b8df826e01a9b48a76de58868014"
    private var completionHandler: ((Weather) -> Void)?
    
    public func loadWetherData(_ completionHandler: @escaping((Weather) -> Void)) {
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // https://api.openweathermap.org/data/3.0/onecall?lat={lat}&lon={lon}&exclude={part}&appid={API key}
    private func makeDataRequest(forCoordinates coordinateS: CLLocationCoordinate2D) {
        guard let urlString = "https://api.openweathermap.org/data/3.0/onecall?lat=\(coordinates.lattitude)&lon=\(coordinate.longitude)&exclude={part}&appid={API_KEY}&units=metric"
            .addingPercentEncoding(withAllowedCharacters: urlQueryAllowed) else { return }
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data. response, error in
            guard error == nill, let data = data else { return }
        }
        
    }
}

struct APIResponse {
    let name: String
    let main: APIMain
    let weather: [APIWeather]
}

struct APIMain: Decodable {
    let temp: Double
}

struct APIWeather: Decodable {
    let description: String
    let iconName: String
    
    enum CodingKeys: String, CodingKeys {
        case description
        case iconName = "main"
    }
}
