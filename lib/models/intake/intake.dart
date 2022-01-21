class Intake {
  String? id;
  double? amount;
  DateTime? createdAt;

  Intake(
    final this.id,
    final this.amount,
    final this.createdAt,
  );

  Intake fromJson(Map<String, dynamic> json) {
    return Intake(
      json['id'],
      double.tryParse(json['amount']),
      DateTime.tryParse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson(Intake intake) {
    return {
      "id": intake.id,
      "amount": intake.amount,
      "created_at": intake.createdAt,
    };
  }
}
