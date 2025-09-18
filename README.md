
# MealsApp — Architecture & Flows

This document captures the high-level architecture and the event/data flows (Callback vs Combine), plus per-feature object relationships used in the app.

---

## Table of Contents
- [Project Architecture](#project-architecture)
- [Flow: Callback vs Combine](#flow-callback-vs-combine)
- [Per-Feature Object Relationships](#per-feature-object-relationships)
- [Repository Flows](#repository-flows)
  - [Get Categories (MealRepository)](#get-categories-mealrepository)
  - [Get Meals (MealRepository)](#get-meals-mealrepository)
- [Presenter Flow](#presenter-flow)
- [Figma Board](#figma-board)
- [Notes](#notes)

---

## Project Architecture
![Project Architecture](https://github.com/user-attachments/assets/ee68eacc-622c-4892-8dd1-6c96029ce08b)

---

## Flow: Callback vs Combine
![Flow: Callback vs Combine](https://github.com/user-attachments/assets/3ff2a5db-9010-41c5-b73a-a88e1dedb7f9)

---

## Per-Feature Object Relationships
_(Flow hubungan antar object per fitur)_
![Per-Feature Object Relationships](https://github.com/user-attachments/assets/ed5363b1-3789-478e-b210-52ac4aef33e6)

---

## Repository Flows

### Get Categories (MealRepository)
![FlowChart Get Categories in MealRepository](https://github.com/user-attachments/assets/b7275491-0da9-41fb-8665-9cb5d1f0aa51)

### Get Meals (MealRepository)
![FlowChart Get Meals in MealRepository](https://github.com/user-attachments/assets/d3f2b8a3-e8ef-4a24-a3ad-ef7b9b528f52)

---

## Presenter Flow
_(FlowChart fungsi `getCategories` → `HomePresenter`)_
![FlowChart getCategories in presenter](https://github.com/user-attachments/assets/50aa48d6-142d-4efa-9d47-0c6675bb60ed)

_(FlowChart fungsi `getMeals` → `DetailCategoryPresenter`)_
![FlowChart getCategories in presenter](https://github.com/user-attachments/assets/4fdcf582-25c5-4f8f-8b9a-a0a1cb743d8d)

---

## Figma Board
- Board: https://www.figma.com/board/GqHXl8JYy4oGgwFSUVjLGD/Untitled?node-id=0-1&p=f&t=NUbm8bJtxS7jBfQr-0

---

## Notes
- Semua diagram di atas adalah _single source of truth_ untuk komunikasi arsitektur dan alur data.
- Jika ada perubahan arsitektur/flow, **perbarui diagram & tautan** ini agar tetap sinkron.
- Untuk diagram tambahan, pakai penamaan konsisten:  
  `FlowChart - <Layer/Feature> - <Action/UseCase>.png`


