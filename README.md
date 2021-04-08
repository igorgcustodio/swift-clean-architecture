#  Clean Architecture iOS App

## About

App developed following the [Swift - TDD, Clean Architecture, Design Patterns, SOLID, MVP](https://www.udemy.com/course/swift-tdd-com-mango/) Udemy course.

This app uses MVP (Model, View, Presenter) pattern with concepts from Clean Archicterure and SOLID and it was developed using TDD.

## Layers

- Domain: Models and UseCases
- Data: UseCases of Domain's UseCases + Tests
- Infra: HTTP adapters (here we can use Alamofire, native networking or any other framework to implement the way to get the data) + Tests
- Presentation: Integration between UI layer and Data layer + Tests
- UI: screens and components + Tests
- Validation: validators rules + Tests
- Main: root and composition layer + Tests

All layers are separated in modules and contains procotols (interfaces) to communicate to others layers.

## Dependencies

- Alamofire: 5.4.1 (via Swift Package Manager)
