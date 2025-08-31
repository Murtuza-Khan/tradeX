import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest,
                             withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)

        guard let bestAttemptContent = bestAttemptContent else {
            return
        }

        if let imageURLString = bestAttemptContent.userInfo["fcm_options"] as? [String: Any],
           let imageURL = imageURLString["image"] as? String,
           let url = URL(string: imageURL) {
            downloadImage(from: url) { attachment in
                if let attachment = attachment {
                    bestAttemptContent.attachments = [attachment]
                }
                contentHandler(bestAttemptContent)
            }
        } else {
            contentHandler(bestAttemptContent)
        }
    }

    private func downloadImage(from url: URL, completion: @escaping (UNNotificationAttachment?) -> Void) {
        URLSession.shared.downloadTask(with: url) { tempFileUrl, _, _ in
            guard let tempFileUrl = tempFileUrl else {
                completion(nil)
                return
            }

            let fileManager = FileManager.default
            let fileExtension = url.pathExtension
            let uniqueURL = URL(fileURLWithPath: NSTemporaryDirectory())
                .appendingPathComponent(UUID().uuidString + "." + fileExtension)

            try? fileManager.moveItem(at: tempFileUrl, to: uniqueURL)

            let attachment = try? UNNotificationAttachment(identifier: "image", url: uniqueURL, options: nil)
            completion(attachment)
        }.resume()
    }

    override func serviceExtensionTimeWillExpire() {
        if let contentHandler = contentHandler, let bestAttemptContent = bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
}
