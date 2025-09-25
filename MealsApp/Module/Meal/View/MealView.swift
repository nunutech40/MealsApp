//
//  MealView.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 24/09/25.
//


import SwiftUI
import CachedAsyncImage

struct MealView: View {
    
    @State private var showingAllert = false
    @ObservedObject var presenter: MealPresenter
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                LoadingIndicatorViewCustom()
            } else if presenter.isError {
                ErrorIndicatorView(title: presenter.errorMessage)
            } else {
                ScrollView(.vertical) {
                    VStack {
                        imageMeal
                        menuButtonMeal
                        content
                    }.padding()
                }
            }
        }.onAppear() {
            self.presenter.getMeal()
        }.alert(isPresented: $showingAllert) {
            Alert(
                title: Text("Oops"),
                message: Text("Something Wrong!"),
                dismissButton: .default(Text("OK"))
            )
        }.navigationBarTitle(
            Text(presenter.meal.title),
            displayMode: .automatic
        )
    }
}

extension MealView {
    
    var menuButtonMeal: some View {
      HStack(alignment: .center) {
        Spacer()
        CustomIcon(
          imageName: "link.circle",
          title: "Source"
        ).onTapGesture {
          self.openUrl(self.presenter.meal.source)
        }
        Spacer()
        CustomIcon(
          imageName: "video",
          title: "Video"
        ).onTapGesture {
          self.openUrl(self.presenter.meal.youtube)
        }
        Spacer()
        if presenter.meal.favorite {
          CustomIcon(
            imageName: "heart.fill",
            title: "Favorited"
          ).onTapGesture {
              // self.presenter.updateFavoriteMeal()
          }
        } else {
          CustomIcon(
            imageName: "heart",
            title: "Favorite"
          ).onTapGesture {
              // self.presenter.updateFavoriteMeal()
          }
        }
        Spacer()
      }.padding()
    }

    var imageMeal: some View {
      CachedAsyncImage(url: URL(string: self.presenter.meal.image)) { image in
        image.resizable()
      } placeholder: {
        ProgressView()
      }.scaledToFill()
        .frame(width: UIScreen.main.bounds.width - 32, height: 250.0, alignment: .center)
        .cornerRadius(30)
    }

    var content: some View {
      VStack(alignment: .leading, spacing: 8) {
        if !presenter.meal.ingredients.isEmpty {
          Text("Ingredient")
            .font(.headline)

          ForEach(self.presenter.meal.ingredients, id: \.id) { ingredient in
            ZStack {
              Text(ingredient.title)
                .font(.system(size: 16))
            }
          }
        }

        Divider()
          .padding(.vertical)

        Text("Instructions")
          .font(.headline)

        Text(self.presenter.meal.instructions)
          .font(.system(size: 16))
      }.padding(.top)
    }
}

extension MealView {
    
    func openUrl(_ linkUrl: String) {
      if let link = URL(string: linkUrl) {
        UIApplication.shared.open(link)
      } else {
          showingAllert = true
      }
    }
    
}
