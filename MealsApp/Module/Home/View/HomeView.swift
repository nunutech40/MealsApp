//
//  HomeView.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//
import SwiftUI
import Core
import Category

struct HomeView: View {
    
    @ObservedObject var presenter: GetListPresenter<Any, CategoryDomainModel, Interactor<Any, [CategoryDomainModel], GetCategoriesRepository<GetCategoriesLocaleDataSource, GetCategoriesRemoteDataSource, CategoryTransformer>>>
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                
                loadingIndicator
            } else if presenter.isError {
                
                errorIndicator
            } else if presenter.list.isEmpty {
                
                emptyCategories
            } else {
                content
            }
        }.onAppear {
            if self.presenter.list.count == 0 {
                self.presenter.getList(request: nil)
            }
        }.navigationBarTitle(
            Text("Meals Apps"),
            displayMode: .automatic
        )
    }
    
}

extension HomeView {
    
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
            ProgressView()
        }
    }
    
    var errorIndicator: some View {
        CustomEmptyView(
            image: "assetSearchNotFound",
            title: presenter.errorMessage
        ).offset(y: 80)
    }
    
    var emptyCategories: some View {
        CustomEmptyView(
            image: "assetNoFavorite",
            title: "The meal category is empty"
        ).offset(y: 80)
    }
    
    // == SECTION 1: Meal Detail (statis) ==
    var mealDetailSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Featured Meal")
                .font(.title3.weight(.semibold))
                .padding(.horizontal, 16)
            
            RandoomFoodView()
                .padding(.horizontal, 16)
        }
        .padding(.top, 16)
    }
    
    private var gridCols: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)
    }
    
    // == CONTENT: sisipkan Section 1 sebelum daftar kategori ==
    var content: some View {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(alignment: .leading, spacing: 20) {

          // SECTION 1
          mealDetailSection

          // SECTION 2
          Text("Categories")
            .font(.title3.weight(.semibold))
            .padding(.horizontal, 16)

          LazyVGrid(columns: gridCols, spacing: 12) {
            ForEach(Array(presenter.list.enumerated()), id: \.element.id) { idx, category in
              CategoryRow(
                category: category,
                // contoh pola: tile kolom kiri (idx % 3 == 0) di-highlight
                isHighlighted: idx % 3 == 0
              )
            }
          }
          .padding(.horizontal, 16)
          .padding(.bottom, 24)
        }
        .padding(.top, 8)
      }
    }

}
