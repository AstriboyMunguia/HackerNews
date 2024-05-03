//
//  DetailsView.swift
//  HackerNews
//
//  Created by Eduardo Geovanni Pérez Munguía on 29/04/24.
//

import SwiftUI
import WebKit

struct ArticleItem: Identifiable {
    //var viewModel: Hit
    
    let id: String
    let title: String
    let author: String
    let content: String
}



//    var body: some View {
//
//        NavigationLink<Text, ListArticleView> () {
//            let viewModel = viewModel(id: "1", title: "Titulo de la noticia", author: "Autor de la noticia", content: "contenido de la noticia...")

struct ArticleView: View {
    let articleItemURL: String
    
    var body: some View {
        VStack{
            viewModel(url: articleItemURL)
        }
        .padding()
        .navigationTitle("Articles")
    }
}



struct WebView: UIViewRepresentable {
    let url : URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView( _ uiView: WKWebView, context: Context) {}
    
}



struct viewModel: View {
    var url : String
    var body : some View {
        WebView(url: URL(string: url)!)
            .edgesIgnoringSafeArea(.all)
    }
}
