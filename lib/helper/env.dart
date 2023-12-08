/*
 * @Author: Levi Li
 * @Date: 2023-12-08 16:49:14
 * @description: 
 */
const defaultAPIServerURL = 'https://ai-api.aicode.cc';

String get apiServerURL {
  var url = const String.fromEnvironment(
    'API_SERVER_URL',
    defaultValue: defaultAPIServerURL,
  );

  // 配置为/时，自动替换为空
  if (url == '/') {
    return '';
  }
  return url;
}
