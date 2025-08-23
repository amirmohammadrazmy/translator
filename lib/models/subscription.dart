enum SubscriptionStatus {
  free,
  subscribed,
  expired,
}

class Subscription {
  final SubscriptionStatus status;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? transactionId;
  final String? bazaarToken;

  Subscription({
    this.status = SubscriptionStatus.free,
    this.startDate,
    this.endDate,
    this.transactionId,
    this.bazaarToken,
  });

  // Check if subscription is active
  bool get isActive {
    if (status != SubscriptionStatus.subscribed) return false;
    if (endDate == null) return false;
    return DateTime.now().isBefore(endDate!);
  }

  // Check if subscription is expired
  bool get isExpired {
    if (status != SubscriptionStatus.subscribed) return true;
    if (endDate == null) return true;
    return DateTime.now().isAfter(endDate!);
  }

  // Get remaining days
  int get remainingDays {
    if (!isActive) return 0;
    final remaining = endDate!.difference(DateTime.now()).inDays;
    return remaining > 0 ? remaining : 0;
  }

  // Create from JSON
  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      status: SubscriptionStatus.values.firstWhere(
        (e) => e.toString() == 'SubscriptionStatus.${json['status']}',
        orElse: () => SubscriptionStatus.free,
      ),
      startDate: json['startDate'] != null 
          ? DateTime.parse(json['startDate'] as String) 
          : null,
      endDate: json['endDate'] != null 
          ? DateTime.parse(json['endDate'] as String) 
          : null,
      transactionId: json['transactionId'] as String?,
      bazaarToken: json['bazaarToken'] as String?,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status.toString().split('.').last,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'transactionId': transactionId,
      'bazaarToken': bazaarToken,
    };
  }

  // Create a copy with updated values
  Subscription copyWith({
    SubscriptionStatus? status,
    DateTime? startDate,
    DateTime? endDate,
    String? transactionId,
    String? bazaarToken,
  }) {
    return Subscription(
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      transactionId: transactionId ?? this.transactionId,
      bazaarToken: bazaarToken ?? this.bazaarToken,
    );
  }

  // Create a new subscription
  factory Subscription.create({
    required DateTime startDate,
    required DateTime endDate,
    required String transactionId,
    String? bazaarToken,
  }) {
    return Subscription(
      status: SubscriptionStatus.subscribed,
      startDate: startDate,
      endDate: endDate,
      transactionId: transactionId,
      bazaarToken: bazaarToken,
    );
  }

  // Create a free subscription
  factory Subscription.free() {
    return Subscription(status: SubscriptionStatus.free);
  }

  @override
  String toString() {
    return 'Subscription(status: $status, startDate: $startDate, endDate: $endDate, transactionId: $transactionId, isActive: $isActive, remainingDays: $remainingDays)';
  }
} 