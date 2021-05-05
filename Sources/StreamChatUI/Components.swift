//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import StreamChat
import UIKit

public typealias Components = _Components<NoExtraData>

public struct _Components<ExtraData: ExtraDataTypes> {
    /// A view used as an online activity indicator (online/offline).
    public var onlineIndicatorView: (UIView & MaskProviding).Type = ChatOnlineIndicatorView.self

    /// A view that displays the avatar image. By default a circular image.
    public var avatarView: ChatAvatarView.Type = ChatAvatarView.self

    /// An avatar view with an online indicator.
    public var presenceAvatarView: _ChatPresenceAvatarView<ExtraData>.Type = _ChatPresenceAvatarView<ExtraData>.self

    /// A view that displays a quoted message.
    public var messageQuoteView: _ChatMessageQuoteView<ExtraData>.Type = _ChatMessageQuoteView<ExtraData>.self

    /// A `UIView` subclass which serves as container for `typingIndicator` and `UILabel` describing who is currently typing
    public var typingIndicatorView: _TypingIndicatorView<ExtraData>.Type = _TypingIndicatorView<ExtraData>.self
    
    /// A `UIView` subclass with animated 3 dots for indicating that user is typing.
    public var typingAnimationView: TypingAnimationView.Type = TypingAnimationView.self

    /// A view for inputting text with placeholder support.
    public var inputTextView: ChatInputTextView.Type = ChatInputTextView.self

    /// A view that displays the command name and icon.
    public var commandLabel: _ChatCommandLabel<ExtraData>.Type = _ChatCommandLabel<ExtraData>.self

    /// A view to input content of a message.
    public var messageInputView: _ChatMessageInputView<ExtraData>.Type = _ChatMessageInputView<ExtraData>.self

    /// An object responsible for message layout options calculations in `ChatMessageListVC/ChatThreadVC`.
    public var messageLayoutOptionsResolver: _ChatMessageLayoutOptionsResolver<ExtraData> = .init()

    /// Button used for sending a message, or any type of content.
    public var sendButton: UIButton.Type = ChatSendButton.self

    /// Button for confirming actions.
    public var confirmButton: UIButton.Type = ChatConfirmButton.self

    /// A view to check/uncheck an option.
    public var checkmarkControl: ChatCheckboxControl.Type =
        ChatCheckboxControl.self

    // MARK: - Message list components

    /// The view used to display content of the message, i.e. in the channel detail message list.
    public var messageContentView: _ChatMessageContentView<ExtraData>.Type = _ChatMessageContentView<ExtraData>.self

    /// The injector used to inject gallery attachment views
    public var galleryAttachmentInjector: _AttachmentViewInjector<ExtraData>.Type = _GalleryAttachmentViewInjector<ExtraData>.self

    public var channelList = ChannelList()
    public var messageList = MessageListUI()
    public var messageComposer = MessageComposer()
    public var currentUser = CurrentUser()
    public var navigation = Navigation()

    public init() {}
}

// MARK: - Components + Default

private var defaults: [String: Any] = [:]

public extension _Components {
    static var `default`: Self {
        get {
            let key = String(describing: ExtraData.self)
            if let existing = defaults[key] as? Self {
                return existing
            } else {
                let config = Self()
                defaults[key] = config
                return config
            }
        }
        set {
            let key = String(describing: ExtraData.self)
            defaults[key] = newValue
        }
    }
}