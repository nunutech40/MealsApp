//
//  LoadingIndicator.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 25/09/25.
//

import SwiftUI

struct LoadingIndicatorViewCustom: View {
    var body: some View {
        VStack {
            Text("Loading...")
            ProgressView()
        }
    }
}
