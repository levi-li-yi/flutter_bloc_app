/*
 * @Author: Levi Li
 * @Date: 2023-12-08 17:30:43
 * @description: 
 */
class Capabilities {
  /// 是否支持 Apple Pay
  final bool applePayEnabled;

  /// 是否支持其它
  final bool otherPayEnabled;

  /// 是否支持翻译
  final bool translateEnabled;

  /// 是否支持邮箱
  final bool mailEnabled;

  /// 是否支持 OpenAI
  final bool openaiEnabled;

  /// 首页显示的模型信息
  final List<HomeModel> homeModels;

  /// 是否显示首页模型描述
  final bool showHomeModelDescription;

  /// 首页路由
  final String homeRoute;

  /// 是否支持 Websocket
  final bool supportWebsocket;

  /// 是否支持 API Keys 功能
  final bool supportAPIKeys;

  /// 是否显示绘玩
  final bool disableGallery;

  /// 是否支持创作岛
  final bool disableCreationIsland;

  /// 是否禁用数字人
  final bool disableDigitalHuman;

  /// 是否禁用聊天
  final bool disableChat;

  /// 服务状态页
  final String serviceStatusPage;

  Capabilities({
    required this.applePayEnabled,
    required this.otherPayEnabled,
    required this.translateEnabled,
    required this.mailEnabled,
    required this.openaiEnabled,
    required this.homeModels,
    this.homeRoute = '/chat-chat',
    this.showHomeModelDescription = true,
    this.supportWebsocket = false,
    this.supportAPIKeys = false,
    this.disableGallery = false,
    this.disableCreationIsland = false,
    this.disableDigitalHuman = false,
    this.disableChat = false,
    this.serviceStatusPage = '',
  });

  factory Capabilities.fromJson(Map<String, dynamic> json) {
    return Capabilities(
      applePayEnabled: json['apple_pay_enabled'] ?? false,
      otherPayEnabled: json['other_pay_enabled'] ?? false,
      translateEnabled: json['translate_enabled'] ?? false,
      mailEnabled: json['mail_enabled'] ?? false,
      openaiEnabled: json['openai_enabled'] ?? false,
      homeModels: ((json['home_models'] ?? []) as List<dynamic>)
          .map((e) => HomeModel.fromJson(e))
          .toList(),
      homeRoute: json['home_route'] ?? '/chat-chat',
      showHomeModelDescription: json['show_home_model_description'] ?? true,
      supportWebsocket: json['support_websocket'] ?? false,
      supportAPIKeys: json['support_api_keys'] ?? false,
      disableGallery: json['disable_gallery'] ?? false,
      disableCreationIsland: json['disable_creation_island'] ?? false,
      disableDigitalHuman: json['disable_digital_human'] ?? false,
      disableChat: json['disable_chat'] ?? false,
      serviceStatusPage: json['service_status_page'] ?? '',
    );
  }
}

// 首页显示的模型信息
class HomeModel {
  final String name;
  final String modelId;
  final String desc;
  final String color;
  final bool powerful;
  final supportVision;

  HomeModel({
    required this.name,
    required this.modelId,
    required this.desc,
    required this.color,
    this.powerful = false,
    this.supportVision = false,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        name: json['name'],
        modelId: json['model_id'],
        desc: json['desc'] ?? '',
        color: json['color'] ?? 'FF67AC5C',
        powerful: json['powerful'] ?? false,
        supportVision: json['supportVision'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'model_id': modelId,
        'desc': desc,
        'color': color,
        'powerful': powerful,
        'supportVision': supportVision,
      };
}
