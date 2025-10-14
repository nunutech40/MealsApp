//
//  RandoomFoodView.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 14/10/25.
//


// ====== Komponen kartu statis ======

import SwiftUI

struct RandoomFoodView: View {
  // ganti URL/image asset sesuai kebutuhanmu
  private let sampleImageURL = URL(string: "https://www.themealdb.com/images/media/meals/llcbn01574260722.jpg")

  private let title = "Beef Wellington"
  private let category = "Beef"
  private let area = "British"
  private let tag = "Gourmet"
  private let ingredients: [String] = [
    "Beef fillet • 500g",
    "Mushroom duxelles",
    "Parma ham",
    "Puff pastry",
    "Egg wash"
  ]
  private let instructions =
"""
Season beef, sear all sides. Wrap with duxelles + parma ham, chill. Encase in puff pastry, egg wash, score top. Bake 200°C ±35–40 min until desired doneness. Rest before slicing, serve with jus.
"""

  @State private var expanded = false

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {

      // Image
      Group {
        #if os(iOS)
        if let url = sampleImageURL {
          AsyncImage(url: url) { phase in
            switch phase {
            case .success(let img): img.resizable().scaledToFill()
            case .failure(_): placeholder
            default: ZStack { Color.secondary.opacity(0.08); ProgressView() }
            }
          }
        } else { placeholder }
        #else
        placeholder
        #endif
      }
      .frame(height: 180)
      .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

      // Title + meta chips
      VStack(alignment: .leading, spacing: 8) {
        Text(title).font(.headline)

        HStack(spacing: 8) {
          MetaChip(text: category)
          MetaChip(text: area)
          MetaChip(text: tag)
        }
      }

      // Ingredients (ringkas)
      if !ingredients.isEmpty {
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: 8) {
            ForEach(ingredients, id: \.self) { ing in
              MetaChip(text: ing)
            }
          }
          .padding(.vertical, 2)
        }
      }

      // Instructions (collapsible)
      VStack(alignment: .leading, spacing: 6) {
        Text("Instructions").font(.subheadline.weight(.semibold))
        Text(instructions)
          .font(.caption)
          .foregroundStyle(.secondary)
          .lineLimit(expanded ? nil : 4)

        Button(expanded ? "Show less" : "Read more") {
          withAnimation(.easeInOut) { expanded.toggle() }
        }
        .font(.caption).foregroundStyle(.blue)
      }
    }
    .padding(16)
    .background(
      RoundedRectangle(cornerRadius: 16, style: .continuous)
        .fill(.background)
        .shadow(color: .black.opacity(0.06), radius: 10, y: 6)
    )
  }

  private var placeholder: some View {
    Color.secondary.opacity(0.1)
      .overlay(
        Image(systemName: "photo")
          .font(.system(size: 28, weight: .regular))
          .foregroundStyle(.secondary)
      )
  }
}

private struct MetaChip: View {
  let text: String
  var body: some View {
    Text(text)
      .font(.caption2)
      .padding(.horizontal, 8).padding(.vertical, 5)
      .background(RoundedRectangle(cornerRadius: 8).fill(Color.secondary.opacity(0.12)))
  }
}
