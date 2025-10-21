<a id="top"></a>

# MealsApp — Architecture & Flows

Dokumen ini merangkum arsitektur app, alur event/data (Callback vs Combine), dan hubungan objek per fitur.

**Navigasi cepat:** [Project Architecture](#project-architecture) • [Flows](#flow-callback-vs-combine) • [Repository](#repository-flows) • [Presenter](#presenter-flow) • [Figma](#figma-board)

---

## Table of Contents
- [Modular Architecture](#modular-architecture)
- [Project Architecture](#project-architecture)
- [Template Flow UI — Halaman](#flow-load-view-halaman)
- [Flow: Callback vs Combine](#flow-callback-vs-combine)
- [Per-Feature Object Relationships](#per-feature-object-relationships)
- [Repository Flows](#repository-flows)
  - [Get Categories (MealRepository)](#get-categories-mealrepository)
  - [Get Meals (MealRepository)](#get-meals-mealrepository)
  - [Get Meal(by idMeal) (MealRepository)](#get-mealby-idmeal-mealrepository)
  - [Get FavoriteMeals (MealRepository)](#get-favoritemeals-mealrepository)
  - [Update FavoriteMeal (MealRepository)](#update-favoritemeal-mealrepository)
  - [Search Meals (MealRepository)](#search-meals-mealrepository)
- [Presenter Flow](#presenter-flow)
- [Figma Board](#figma-board)
- [Notes](#notes)

---

## Modular Architecture
[⬆︎ Back to Top](#top)

<!-- Klik gambar → lompat ke Project Architecture -->
[![Modular Architecture](https://github.com/user-attachments/assets/1315b256-b584-429e-8da6-8e80f7fc83d9)](#project-architecture)

---

## Project Architecture
[⬆︎ Back to Top](#top)

![Project Architecture](https://github.com/user-attachments/assets/6e628dc9-faf5-4592-8d8a-1bd4bb28e090)

---

## Flow Load View Halaman
[⬆︎ Back to Top](#top)

![Load View Halaman](https://github.com/user-attachments/assets/add88b85-5822-4c95-9d94-78852c4fbaf0)

---

## Flow: Callback vs Combine
[⬆︎ Back to Top](#top)

![Flow: Callback vs Combine](https://github.com/user-attachments/assets/3ff2a5db-9010-41c5-b73a-a88e1dedb7f9)

---

## Per-Feature Object Relationships
[⬆︎ Back to Top](#top)

![Per-Feature Object Relationships](https://github.com/user-attachments/assets/ed5363b1-3789-478e-b210-52ac4aef33e6)

---

## Repository Flows
[⬆︎ Back to Top](#top)

### Get Categories (MealRepository)
[↩︎ Repos](#repository-flows)

![FlowChart Get Categories in MealRepository](https://github.com/user-attachments/assets/b7275491-0da9-41fb-8665-9cb5d1f0aa51)

---

### Get Meals (MealRepository)
[↩︎ Repos](#repository-flows)

![FlowChart Get Meals in MealRepository](https://github.com/user-attachments/assets/d3f2b8a3-e8ef-4a24-a3ad-ef7b9b528f52)

---

### Get Meal(by idMeal) (MealRepository)
[↩︎ Repos](#repository-flows)

![FlowChart Get MealById in MealRepository](https://github.com/user-attachments/assets/3dc232ec-7792-40b1-94f3-a3f73a30a019)

---

### Get FavoriteMeals (MealRepository)
[↩︎ Repos](#repository-flows)

![FlowChart Get FavoriteMeals in MealRepository](https://github.com/user-attachments/assets/d73ca415-1502-4feb-b258-e86701bf883c)

---

### Update FavoriteMeal (MealRepository)
[↩︎ Repos](#repository-flows)

![FlowChart Update FavoriteMeals in MealRepository](https://github.com/user-attachments/assets/190bc399-c0d6-43d0-b287-e0ffb0b874c1)

---

### Search Meals (MealRepository)
[↩︎ Repos](#repository-flows)

![FlowChart Search Meals in MealRepository](https://github.com/user-attachments/assets/3f28e9c3-6fc2-4de7-8a1a-0e5d4d553eb3)

---

## Presenter Flow
[⬆︎ Back to Top](#top)

**getCategories → HomePresenter**

![FlowChart getCategories in presenter](https://github.com/user-attachments/assets/50aa48d6-142d-4efa-9d47-0c6675bb60ed)

**getMeals → DetailCategoryPresenter**

![FlowChart getMeals in presenter](https://github.com/user-attachments/assets/4fdcf582-25c5-4f8f-8b9a-a0a1cb743d8d)

---

## Figma Board
[⬆︎ Back to Top](#top)

- Board: https://www.figma.com/board/GqHXl8JYy4oGgwFSUVjLGD/Untitled?node-id=0-1&p=f&t=NUbm8bJtxS7jBfQr-0

---

## Notes
[⬆︎ Back to Top](#top)

- Semua diagram di atas adalah *single source of truth* arsitektur & flow.
- Setiap perubahan arsitektur/flow, **update diagram + link** ini supaya tetap sinkron.
- Penamaan file: `FlowChart - <Layer/Feature> - <Action/UseCase>.png`.
