class BusinessUserRegisterRequestBody {
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? businessName;
  String? businessAddress;
  String? businessPhone;
  String? latitude;
  String? longitude;
  String? city;
  String? metropolitanArea;
  String? contact;
  String? advertiseMedia;
  String? userType;
  String? isEighteen;
  String? isAcceptedTac;
  String? categoryId;
  int? metropolitanAreaId;
  int? cityId;

  BusinessUserRegisterRequestBody(
      String firstName,
      String lastName,
      String username,
      String email,
      String businessName,
      String businessAddress,
      String businessPhone,
      String latitude,
      String longitude,
      String city,
      String metropolitanArea,
      String contact,
      int userType,
      int isEighteen,
      int isAcceptedTac,
      int categoryId,
      String advertiseMedia,
      int metropolitanAreaId,
      int cityId) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.username = username;
    this.email = email;
    this.businessName = businessName;
    this.businessAddress = businessAddress;
    this.businessPhone = businessPhone;
    this.latitude = latitude;
    this.longitude = longitude;
    this.city = city;
    this.metropolitanArea = metropolitanArea;
    this.contact = contact;
    this.userType = userType.toString();
    this.isEighteen = isEighteen.toString();
    this.isAcceptedTac = isAcceptedTac.toString();
    this.categoryId = categoryId.toString();
    this.metropolitanAreaId = metropolitanAreaId;
    this.advertiseMedia = advertiseMedia;
    this.cityId = cityId;
  }
}
