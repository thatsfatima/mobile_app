class Compte {
  final int userId;
  final double balance;
  final double balanceMax;
  final double balanceMensual;
  final String currency;
  final String qrCode;
  final String status;

  Compte({
    required this.userId,
    required this.balance,
    required this.balanceMax,
    required this.balanceMensual,
    required this.currency,
    required this.qrCode,
    required this.status,
  });

  factory Compte.fromJson(Map<String, dynamic> json) {
    return Compte(
      userId: json['user_id'],
      balance: json['balance'],
      balanceMax: json['balanceMax'],
      balanceMensual: json['balanceMensual'],
      currency: json['currency'],
      qrCode: json['qrCode'],
      status: json['status'],
    );
  }

}