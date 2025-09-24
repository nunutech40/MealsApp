//
//  TabItem.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 24/09/25.
//

import SwiftUI

struct TabItem: View {
    
    var imageName: String
    var title: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
            Text(title)
        }
    }
}
