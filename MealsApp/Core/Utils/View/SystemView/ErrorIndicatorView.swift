//
//  ErrorIndicatorView.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 25/09/25.
//

import SwiftUI

struct ErrorIndicatorView: View {
    var title: String
    
    var body: some View {
        CustomEmptyView(
            image: "assetSearchNotFound",
            title: title
        ).offset(y: 80)
    }
}
