//
//  AboutMeView.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 14/10/25.
//

import SwiftUI

struct AboutMeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                // HEADER: Foto besar kiri + nama/role kanan
                HStack(alignment: .center, spacing: 16) {
                    Image("profile") // ganti sesuai asetmu
                        .resizable()
                        .scaledToFill()
                        .frame(width: 180, height: 180) // <<< lebih besar
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.secondary.opacity(0.15), lineWidth: 1)
                        )
                        .shadow(radius: 8)

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Nunu Nugraha")
                            .font(.title.weight(.semibold))
                        Text("iOS Developer")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                }

                // SUMMARY: kiri (leading)
                VStack(alignment: .leading, spacing: 8) {
                    Text("About Me")
                        .font(.title.weight(.bold))
                    Text("""
    Saya seorang iOS developer yang fokus pada SwiftUI dan arsitektur yang bersih. Suka otomasi CI/CD, pengujian yang rapi, dan kolaborasi yang jelas. Terbuka untuk proyek freelance/remote.
    """)
                    .font(.body)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)
                }

            }
            .padding(24)
        }
        .navigationTitle("About Me")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}
