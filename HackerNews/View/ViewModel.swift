//
//  ViewModel.swift
//  HackerNews
//
//  Created by Eduardo Geovanni Pérez Munguía on 29/04/24.
//

import Foundation
import Combine

class ListArticlesViewModel: ObservableObject {
    
    init() {}
    
    @Published var news: [Hit] = []
    @Published var error: Error?
    
    
    let apiClient = ApiClient()
    
    
    func performGetNews() {
        
        apiClient.getNews { [weak self] result in
            
                DispatchQueue.main.async {
                    switch result {
                    // Procesar los datos aquí
                   // print("Datos obtenidos exitosamente: \(news)")
                    case .success(let news):
                    self?.news = news.hits
                        self?.error = nil
            case .failure(let error):
                //DispatchQueue.main.async {
                    // Manejar el error aquí
                    print("Error al obtener los datos: \(error)")
                    self?.error = error
                }
            }
        }
        
    }
}
