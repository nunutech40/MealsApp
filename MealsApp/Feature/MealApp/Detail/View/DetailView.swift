//
//  DetailView.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var presenter: DetailPresenter
    
    var body: some View {
        ZStack {
            if presenter.loadingState {
                loadingIndicator
            } else {
                ScrollView(.vertical) {
                    VStack {
                        imageCategory
                        spacer
                        content
                        spacer
                    }.padding()
                }
            }
        }
    }
}

extension DetailView {
    var spacer: some View {
        Spacer()
    }
    
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
            ProgressView()
        }
    }
    
    var imageCategory: some View {
        AsyncImage(url: URL(string: self.presenter.category.image)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }.scaledToFit().frame(width: 250.0, height: 250.0, alignment: .center)
    }
    
    var description: some View {
        Text(self.presenter.category.description)
            .font(.system(size: 15))
    }
    
    func headerTitle(_ title: String) -> some View {
        return Text(title)
            .font(.headline)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerTitle("Description")
                .padding([.top, .bottom])
            description
        }
    }
}
