class ResponseModel {
  bool? _isSuccess;
  String? _message;
  bool? is_user;
  bool? skip_otp;
  String? token;
  ResponseModel(this._isSuccess, this._message,{this.is_user=false,this.token,this.skip_otp});

  String? get message => _message;
  bool? get isSuccess => _isSuccess;
}