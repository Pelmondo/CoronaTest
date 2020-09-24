//
//  NetworkService.swift
//  CoronaVirus
//
//  Created by Сергей Прокопьев on 24.09.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func getCountryList(completion: @escaping(Result<[CountryAPI]?, Error>) -> Void)
    func getNumberOfCases(_ slug: String, status: Status,
                          to date: String, completion: @escaping(Result<DetailedCountryAPI?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getCountryList(completion: @escaping(Result<[CountryAPI]?, Error>) -> Void) {
        let urlString = "https://api.covid19api.com/countries"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) {data, _, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                do {
                    let obj = try JSONDecoder().decode([CountryAPI].self, from: data!)
                    completion(.success(obj))
                } catch {
                    completion(.failure(error))
            }
        }.resume()
    }
    
    func getNumberOfCases(_ slug: String, status: Status,
                          to date: String, completion: @escaping(Result<DetailedCountryAPI?, Error>) -> Void) {
        let urlString = "https://api.covid19api.com/country/\(slug)/status/\(status)?from=2020-03-01T00:00:00Z&to=\(date)T00:00:00Z"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) {data, _, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                do {
                    let obj = try JSONDecoder().decode([DetailedCountryAPI].self, from: data!)
                    if obj.isEmpty {
                        completion(.success(DetailedCountryAPI(Country: "Пусто", Cases: 0, Status: "Нет данных")))
                    }
                    completion(.success(obj.last))
                } catch {
                    completion(.failure(error))
            }
        }.resume()
    }
}
