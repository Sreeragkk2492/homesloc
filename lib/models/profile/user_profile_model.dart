class UserProfileModel {
  final String id;
  final String name;
  final String primaryEmail;
  final String primaryMobile;
  final String type;
  final String? description;
  final String? additionalInfo;
  final String? profileImageUrl;
  final int rewardsPoints;
  final String? subscriptionStatus;
  final String userType;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  final String message;

  UserProfileModel({
    required this.id,
    required this.name,
    required this.primaryEmail,
    required this.primaryMobile,
    required this.type,
    this.description,
    this.additionalInfo,
    this.profileImageUrl,
    required this.rewardsPoints,
    this.subscriptionStatus,
    required this.userType,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.message,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'User',
      primaryEmail: json['primary_email'] as String? ?? '',
      primaryMobile: json['primary_mobile'] as String? ?? '',
      type: json['type'] as String? ?? 'Regular',
      description: json['description'] as String?,
      additionalInfo: json['additional_info'] as String?,
      profileImageUrl: json['profile_image_url'] as String?,
      rewardsPoints: json['rewards_points'] as int? ?? 0,
      subscriptionStatus: json['subscription_status'] as String?,
      userType: json['user_type'] as String? ?? 'Regular',
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
      message: json['message'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'primary_email': primaryEmail,
      'primary_mobile': primaryMobile,
      'type': type,
      'description': description,
      'additional_info': additionalInfo,
      'profile_image_url': profileImageUrl,
      'rewards_points': rewardsPoints,
      'subscription_status': subscriptionStatus,
      'user_type': userType,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'message': message,
    };
  }
}
