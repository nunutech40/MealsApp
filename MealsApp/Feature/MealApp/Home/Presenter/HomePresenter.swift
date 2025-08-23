//
//  HomePresenter.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import SwiftUI
import RxSwift

class HomePresenter: ObservableObject {
    
    private let router = HomeRouter()
    private let getCategoriesUseCase: GetCategoriesProtocol
    private let disposeBag = DisposeBag()
    
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    @Published var categories: [CategoryModel] = []
    
    init(getCategoriesUseCase: GetCategoriesProtocol) {
        self.getCategoriesUseCase = getCategoriesUseCase
    }
    
    func getCategories() {
        loadingState = true
        
        getCategoriesUseCase.getCategories()
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                print("cek resultnya: \(result)")
                self.categories = result
            } onError: { error in
                self.errorMessage = error.localizedDescription
                self.loadingState = false
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
    
    func linkBuilder<Content: View>(
        for category: CategoryModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: category)) {
                content()
            }
    }
}
