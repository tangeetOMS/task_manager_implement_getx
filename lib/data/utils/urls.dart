class Urls {
  static const _baseUrls = 'https://task.teamrabbil.com/api/v1';
  static const registrationUrl = '$_baseUrls/registration';
  static const loginUrl = '$_baseUrls/login';
  static const createTaskUrl = '$_baseUrls/createTask';
  static const taskCountByStatusUrl = '$_baseUrls/taskStatusCount';
  static String taskListByStatusUrl(String status) =>
      '$_baseUrls/listTaskByStatus/$status';
  static String forgotVerifyEmailUrl(String email) => '$_baseUrls/RecoverVerifyEmail/$email';
  static String forgotVerifyEmailOtpUrl(String email, String otp) => '$_baseUrls/RecoverVerifyOTP/$email/$otp';
  static String deleteTaskUrl (String taskId) => '$_baseUrls/deleteTask/$taskId';
  static String updateTaskUrl (String taskId, String status) =>'$_baseUrls/updateTaskStatus/$taskId/$status';
  static const updateProfileUrl = '$_baseUrls/profileUpdate';
  static const resetPasswordUrl = '$_baseUrls/RecoverResetPass';
}
