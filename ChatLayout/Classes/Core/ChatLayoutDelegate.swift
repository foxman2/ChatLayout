//
// ChatLayout
// ChatLayoutDelegate.swift
// https://github.com/ekazaev/ChatLayout
//
// Created by Eugene Kazaev in 2020-2022.
// Distributed under the MIT license.
//

import Foundation
import UIKit

/// Represents the point in time `ChatLayout` when chat layout asks about layout attributes modification.
public enum InitialAttributesRequestType {

    /// `UICollectionView` initially asks about the layout of an item.
    case initial

    /// An item is being invalidated.
    case invalidation

}

/// `ChatLayout` delegate
public protocol ChatLayoutDelegate: AnyObject {

    /// `ChatLayout` will call this method to ask if it should present the header in the current layout.
    /// - Parameters:
    ///   - chatLayout: ChatLayout reference.
    ///   - sectionIndex: Index of the section.
    /// - Returns: `Bool`.
    func shouldPresentHeader(_ chatLayout: ChatLayout,
                             at sectionIndex: Int) -> Bool

    /// `ChatLayout` will call this method to ask if it should present the footer in the current layout.
    /// - Parameters:
    ///   - chatLayout: ChatLayout reference.
    ///   - sectionIndex: Index of the section.
    /// - Returns: `Bool`.
    func shouldPresentFooter(_ chatLayout: ChatLayout,
                             at sectionIndex: Int) -> Bool

    /// `ChatLayout` will call this method to ask what size the item should have.
    ///
    /// **NB:**
    ///
    /// If you are trying to speed up the layout process by returning exact item sizes in this method -
    /// do not forget to change `UICollectionReusableView.preferredLayoutAttributesFitting(...)` method and do not
    /// call `super.preferredLayoutAttributesFitting(...)` there as it will measure the `UIView`
    /// using Autolayout Engine anyway.
    ///
    /// - Parameters:
    ///   - chatLayout: ChatLayout reference.
    ///   - kind: Type of element represented by `ItemKind`.
    ///   - indexPath: Index path of the item.
    /// - Returns: `ItemSize`.
    func sizeForItem(_ chatLayout: ChatLayout,
                     of kind: ItemKind,
                     at indexPath: IndexPath) -> ItemSize

    /// `ChatLayout` will call this method to ask what type of alignment the item should have.
    /// - Parameters:
    ///   - chatLayout: ChatLayout reference.
    ///   - kind: Type of element represented by `ItemKind`.
    ///   - indexPath: Index path of the item.
    /// - Returns: `ChatItemAlignment`.
    func alignmentForItem(_ chatLayout: ChatLayout,
                          of kind: ItemKind,
                          at indexPath: IndexPath) -> ChatItemAlignment

    ///   Asks the delegate to modify a layout attributes instance so that it represents the initial visual state of an item
    ///   being inserted.
    ///
    ///   The `originalAttributes` instance is a reference type, and therefore can be modified directly.
    ///
    /// - Parameters:
    ///   - chatLayout: ChatLayout reference.
    ///   - kind: Type of element represented by `ItemKind`.
    ///   - indexPath: Index path of the item.
    ///   - originalAttributes: `ChatLayoutAttributes` that the `ChatLayout` is going to use.
    ///   - state: `InitialAttributesRequestType` instance. Represents when is this method being called.
    func initialLayoutAttributesForInsertedItem(_ chatLayout: ChatLayout,
                                                of kind: ItemKind,
                                                at indexPath: IndexPath,
                                                modifying originalAttributes: ChatLayoutAttributes,
                                                on state: InitialAttributesRequestType)

    ///   Asks the delegate to modify a layout attributes instance so that it represents the final visual state of an item
    ///   being removed via `UICollectionView.deleteSections(_:)`.
    ///
    ///   The `originalAttributes` instance is a reference type, and therefore can be modified directly.
    ///
    /// - Parameters:
    ///   - chatLayout: ChatLayout reference.
    ///   - kind: Type of element represented by `ItemKind`.
    ///   - indexPath: Index path of the item.
    ///   - originalAttributes: `ChatLayoutAttributes` that the `ChatLayout` is going to use.
    func finalLayoutAttributesForDeletedItem(_ chatLayout: ChatLayout,
                                             of kind: ItemKind,
                                             at indexPath: IndexPath,
                                             modifying originalAttributes: ChatLayoutAttributes)

}

/// Default extension.
public extension ChatLayoutDelegate {

    /// Default implementation returns: `false`.
    func shouldPresentHeader(_ chatLayout: ChatLayout,
                             at sectionIndex: Int) -> Bool {
        return false
    }

    /// Default implementation returns: `false`.
    func shouldPresentFooter(_ chatLayout: ChatLayout,
                             at sectionIndex: Int) -> Bool {
        return false
    }

    /// Default implementation returns: `ItemSize.auto`.
    func sizeForItem(_ chatLayout: ChatLayout,
                     of kind: ItemKind,
                     at indexPath: IndexPath) -> ItemSize {
        return .auto
    }

    /// Default implementation returns: `ChatItemAlignment.fullWidth`.
    func alignmentForItem(_ chatLayout: ChatLayout,
                          of kind: ItemKind,
                          at indexPath: IndexPath) -> ChatItemAlignment {
        return .fullWidth
    }

    /// Default implementation sets a `ChatLayoutAttributes.alpha` to zero.
    func initialLayoutAttributesForInsertedItem(_ chatLayout: ChatLayout,
                                                of kind: ItemKind,
                                                at indexPath: IndexPath,
                                                modifying originalAttributes: ChatLayoutAttributes,
                                                on state: InitialAttributesRequestType) {
        originalAttributes.alpha = 0
    }

    /// Default implementation sets a `ChatLayoutAttributes.alpha` to zero.
    func finalLayoutAttributesForDeletedItem(_ chatLayout: ChatLayout,
                                             of kind: ItemKind,
                                             at indexPath: IndexPath,
                                             modifying originalAttributes: ChatLayoutAttributes) {
        originalAttributes.alpha = 0
    }

}
