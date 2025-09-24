//
//  CustomIcon.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 24/09/25.
//

import SwiftUI

struct CustomIcon {
    
    var imageName: String
    var title: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .font(.system(size: 28))
                .foregroundColor(.orange)
            
            Text(title)
                .font(.caption)
                .padding(.top, 8)
        }
    }
}
