//
//  CategoryRow.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import SwiftUI
import CachedAsyncImage
import Category
struct CategoryRow: View {
    let category: CategoryDomainModel
    var isHighlighted: Bool = false 

    var body: some View {
        let key = category.id.isEmpty ? category.title : category.id
        VStack(spacing: 8) {
            CachedAsyncImage(url: URL(string: category.image)) { img in
                img.resizable()
            } placeholder: { ProgressView() }
            .scaledToFit()
            .frame(height: 56)
            .padding(.top, 8)

            Text(category.title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.primary)
                .lineLimit(1)

            Spacer(minLength: 6)
        }
        .padding(.horizontal, 10)
        .frame(width: 110, height: 120)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(isHighlighted ? Color(hex: 0xE8F5E9) : tileColor(for: key))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(Color.black.opacity(0.06), lineWidth: 0.5)
        )
        .shadow(color: .black.opacity(0.06), radius: 6, y: 3)
    }
}
