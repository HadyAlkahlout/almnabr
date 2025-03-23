class AuthRequests {
  static const String loginMutation = '''
    mutation (\$mobile: String, \$country_dial: String){
        userLogin(mobile: \$mobile,country_dial: \$country_dial){
            status,
            message,
            is_exists
            otp_length,
            otp_expired_seconds,
            otp
        }
    }
  ''';

  static const String verifyOtpMutation = '''
    mutation (\$mobile: String, \$country_dial: String, \$otp: String, \$action_type: String){
        verifyOtp(mobile: \$mobile, country_dial: \$country_dial, otp: \$otp, action_type: \$action_type){
            status,
            message,
            token,
            data{
                name,
                email,
                mobile,
                country_dial,
                photo
                is_super_admin
            }
        }
    }
  ''';

  static const String resendOtpMutation = '''
    mutation (\$mobile: String, \$country_dial: String, \$action_type: String){
        userResendOtp(mobile: \$mobile,country_dial: \$country_dial, action_type: \$action_type){
            status,
            message,
            otp_length,
            otp_expired_seconds,
            otp
        }
    }
  ''';
}
