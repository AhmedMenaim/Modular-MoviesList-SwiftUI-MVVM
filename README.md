# Branches
- [Main](https://github.com/AhmedMenaim/Modular-MoviesList-SwiftUI-MVVM/tree/main): All in one, That's consider to be the main branch which holds the base modules, No modularization as everything in the same project.
- [Modularization-Caching-Testing](https://github.com/AhmedMenaim/Modular-MoviesList-SwiftUI-MVVM/tree/Modularization-Caching-Testing): Recommended to use this branch which contains the complete app with modularization, Testing for movie details module and applying the caching logic on movies module.

# Demo

| DarkMode + Pagination | Search + Details |
|:----------- |:-------------:|
| ![DarkMode+Pagination](https://github.com/user-attachments/assets/389ee49b-665f-4b20-8ca9-58c9dacba6aa)  | ![Search + Details](https://github.com/user-attachments/assets/298f52a2-aff6-442c-afa8-733d41d94222)


| Genres Filter | LightMode + OfflineState |
|:----------- |:-------------:|
| ![Genres-Filter](https://github.com/user-attachments/assets/a86f7e38-6b77-476d-a05d-6a7d1b3cb0f5) | ![LightMode+OfflineState](https://github.com/user-attachments/assets/9d82018d-2bee-44ed-b0e8-0c49d720bb6d)


# Requirements:
### Functional
  - Fetching and parsing data from API.
  - Listing Data.
  - Navigation to Details view.
  - Search
  - Fetching Genres
  - Filter by Genre
  - Dark mode
    
### Non-Functional:
- Scalability:
  - Modularity.
- Performance:
  - Caching.
  - Pagination
  - Handling offline state
- Reliability:
  - Unit tests.
 
# Diagrams
 - High-Level Diagram
   ![High-Level Diagram](https://github.com/user-attachments/assets/ed7b985d-d0d2-4c7b-8f38-18c3a5241086)


    
- Low-Level Diagram - MVVM with clean architecture
  ![MVVM](https://github.com/user-attachments/assets/327b5748-22fd-4034-8d30-39a3fdf2b474)




# Decisions

- IDE & Deployment target:
  - XCode 15.3
  - Minimum Target: iOS(15)
    
- UI:
  - SwiftUI
  - UIKit - Used in Navigation 
  - MVVM with Clean Architecture (UseCase & Coordinator)

- Principals and Patterns:
  - SOLID conformance:
    - Features are separated into modules.
    - Factory pattern to create each module.
    - Repository for formatting backend data.
    - Coordinator to manage navigation & communication among modules.
    - UseCases for business logic.

- Dependency Manager:
  - Swift Package Manager

- Dependencies:
  
  [Kingfisher](https://github.com/onevcat/Kingfisher): Downloading and caching images from the web.
  
  [Realm](https://github.com/realm/realm-swift): for chaching the list.

   
# What could be improved
- Be more secure and include the API keys in keychain or external tool.
- Pass the parameters in the parameters not the URL
- Implement the needed UI formatting in the viewModel not in the View.
- Spliting the logic more in the usecase.
- Unit testing for the MoviesList.
- Caching for MovieDetails.
- CI/CD
