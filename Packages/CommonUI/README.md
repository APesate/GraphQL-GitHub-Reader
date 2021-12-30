# CommonUI

This package contains a set of convenience classes that could help speed up the development process of any project that wishes to use it.

------

## Usage

Include the package as a you would with any other local SPM dependency.

------

## Content

In its current state this library provides the following benefits:

- Convenience methods and property wrappers to be used for the localization of strings.
- A reusable `ErrorView` that's formed by: One Icon and a description label.

- UIView:
 - [Identifiable](./Sources/CommonUI/Extensions/UIView/UIView+Identifiable.swift): An extension to retrieve the class name as a string. Specially useful when registering TableViewCells and CollectionViewCells.
 - [Borders](./Sources/CommonUI/Extensions/UIView/UIView+Borders.swift): Makes easier adding borders to another view.
 - [Layout](./Sources/CommonUI/Extensions/UIView/UIView+Layout.swift): Currently only allows to create a view with weak Hugging Resistance. Useful as spacer view.

## Dependencies

This project has no dependencies.

## Tests

This project doesn't contain tests.
