//
//  MainView.swift
//  HackerNews
//
//  Created by Eduardo Geovanni Pérez Munguía on 29/04/24.
//


import SwiftUI

struct ListArticleView: View {
    @StateObject var viewModel = ListArticlesViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.news, id: \.objectID) { item in
                        if let urlString = item.storyURL {
                            NavigationLink(destination: ArticleView(articleItemURL: urlString)) {
                                VStack(alignment: .leading) { // Usar VStack para alinear las vistas verticalmente
                                    Text(item.storyTitle ?? "")
                                        .font(.subheadline)
                                    
                                    Text(item.author)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                    Text(item.createdAt)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteNews)
                }
                            .refreshable {
                                viewModel.performGetNews()
                            }
                    .navigationTitle("Hacker News")
                    .toolbar {
                    }
                }
            }
            
            .onAppear {
                viewModel.performGetNews()
            }
        }
    func deleteNews(at offSets: IndexSet) {
        viewModel.news.remove(atOffsets: offSets)
    }
}
