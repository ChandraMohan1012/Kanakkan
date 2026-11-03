/// Data model for SMS messages that could not be parsed by any active template.
/// Stored locally in SQLite quarantine so users can inspect them, dismiss noise,
/// or tap "Create template from this" to teach the app new bank formats.
class UnreadableMessage {
  final String id;
  final String sender;
  final String rawBody;
  final DateTime receivedAt;
  final String reason;
  final bool isIgnored;

  const UnreadableMessage({
    required this.id,
    required this.sender,
    required this.rawBody,
    required this.receivedAt,
    required this.reason,
    this.isIgnored = false,
  });

  /// Sanitizes sensitive data (masks account numbers, cards, links, OTPs)
  /// so it can be safely reported or used in the template builder.
  String get sanitizedBody {
    var text = rawBody;
    // Mask account numbers: "A/c 123456789" -> "A/c [MASKED]"
    text = text.replaceAll(RegExp(r'(?<=\b\d{2,4})\d{4,}(?=\b)'), '****');
    // Mask URLs
    text = text.replaceAll(RegExp(r'https?://\S+'), '[LINK]');
    // Mask OTP values: "OTP is 123456" -> "OTP is [OTP]"
    text = text.replaceAll(
        RegExp(r'\bOTP(?:\s+is)?\s+(\d{4,8})\b', caseSensitive: false),
        'OTP [MASKED]');
    return text;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sender': sender,
      'raw_body': rawBody,
      'received_at': receivedAt.toIso8601String(),
      'reason': reason,
      'is_ignored': isIgnored ? 1 : 0,
    };
  }

  factory UnreadableMessage.fromMap(Map<String, dynamic> map) {
    return UnreadableMessage(
      id: map['id'] as String,
      sender: map['sender'] as String,
      rawBody: map['raw_body'] as String,
      receivedAt: DateTime.parse(map['received_at'] as String),
      reason: map['reason'] as String,
      isIgnored: (map['is_ignored'] as int? ?? 0) == 1,
    );
  }
}

class UnreadableStore {
  final List<UnreadableMessage> _items = [];

  List<UnreadableMessage> get items => List.unmodifiable(_items);

  void recordUnreadable({
    required String sender,
    required String body,
    required DateTime receivedAt,
    required String failureReason,
  }) {
    final msg = UnreadableMessage(
      id: 'unreadable_${DateTime.now().microsecondsSinceEpoch}',
      sender: sender,
      rawBody: body,
      receivedAt: receivedAt,
      reason: failureReason,
    );
    _items.add(msg);
  }

  void markIgnored(String id) {
    final index = _items.indexWhere((m) => m.id == id);
    if (index != -1) {
      final old = _items[index];
      _items[index] = UnreadableMessage(
        id: old.id,
        sender: old.sender,
        rawBody: old.rawBody,
        receivedAt: old.receivedAt,
        reason: old.reason,
        isIgnored: true,
      );
    }
  }

  void clear() {
    _items.clear();
  }
}
