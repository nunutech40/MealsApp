//
//  MealDetailUseCase.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 17/10/25.
//

import Combine

// Protokol ini adalah 'kontrak' untuk MealDetailView
// Dia tidak mendefinisikan fungsi baru, hanya MENGGABUNGKAN kontrak lain.
protocol MealDetailUseCase: MealUseCase, MealUpdateFavoriteUseCase {
    // Isinya bisa kosong!
    // Dengan menulis ini, kita bilang: "Siapapun yang mau jadi MealDetailUseCase,
    // dia WAJIB punya semua kemampuan dari GetMealUseCase DAN UpdateFavoriteMealUseCase."
}
