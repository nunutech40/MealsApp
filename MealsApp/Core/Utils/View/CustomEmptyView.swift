//
//  CustomEmptyView.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 17/09/25.
//

import SwiftUI

struct CustomEmptyView: View {
    var image: String
    var title: String
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .renderingMode(.original)
                .scaledToFit()
                .frame(width: 200)
            
            Text(title)
                .font(.system(.body, design: .rounded))
        }
    }
}
