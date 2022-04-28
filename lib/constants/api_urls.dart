class ApiUrls {
  static const String base_url = "http://18.191.193.64/";
  // static const String base_url = "http://192.168.29.68:8001/";
  static const String user_register_url = base_url + "api/register";
  static const String send_otp_url = base_url + "api/send_otp";
  static const String verify_otp_url = base_url + "api/verify_otp_new";
  static const String signin_url = base_url + "api/signin";
  static const String profile_url = base_url + "api/profile";
  static const String logout_url = base_url + "api/logout";
  static const String update_profile_url = base_url + "api/update_profile";
  static const String list_location_url = base_url + "api/list_location";
  static const String business_list_url = base_url + "api/list_business";
  static const String create_feed_url = base_url + "api/create_feed";
  static const String home_feed_list_url = base_url + "api/list_home_feeds";
  static const String like_dislike_home_feed_url =
      base_url + "api/feed_like_dislikes";
  static const String categories_list_url = base_url + "api/view_categories";
  static const String mycheck_ins_list_url = base_url + "api/list_my_check_ins";
  static const String view_feed_url = base_url + "api/view_feed";
  static const String list_business_home_feed_url =
      base_url + "api/list_business_home_feed";
  static const String get_one_feed_url = base_url + "api/get_one_feed";
  static const String create_comment_url = base_url + "api/create_comment";
  static const String metropolitan_areas_list_url =
      base_url + "api/list_metropolitan_areas";
  static const String like_home_feed_url = base_url + "api/feed_like";
  static const String business_profile_url = base_url + "api/business_profile";
  static const String update_business_profile_url =
      base_url + "api/update_business_profile";
  static const String search_by_business_url =
      base_url + "api/search_by_business";
  static const String follow_business_url = base_url + "api/follow_business";
  static const String list_notifications_url =
      base_url + "api/list_notifications";
  static const String unfollow_business_url =
      base_url + "api/unfollow_business";
  static const String list_liked_business_url =
      base_url + "api/list_liked_business";
  static const String delete_feed_url = base_url + "api/delete_feed";
  static const String unlike_business_url = base_url + "api/unlike_business";
  static const String like_business_url = base_url + "api/like_business";
  static const String save_notification_settings_url =
      base_url + "api/save_notification_setting";
  static const String deactivate_account_url =
      base_url + "api/deactivate_account";
  static const String delete_account_url = base_url + "api/delete_account";
  static const String click_feed_url = base_url + "api/click_feed";
  static const String update_list_keywords_url =
      base_url + "api/update_list_keywords";
  static const String graph_like_url = base_url + "api/graph_like";
  static const String graph_likes_url = base_url + "api/graph_likes";
  static const String graph_view_url = base_url + "api/graph_view";
  static const String graph_views_url = base_url + "api/graph_views";
  static const String graph_click_url = base_url + "api/graph_click";
  static const String graph_clicks_url = base_url + "api/graph_clicks";
  static const String business_details_url = base_url + "api/business_details";
  static const String dislike_business_url = base_url + "api/dislike_business";
  static const String list_disliked_business_url =
      base_url + "api/list_disliked_business";
  static const String add_business_latlong_url =
      base_url + "api/add_business_latlong";
  static const String delete_business_latlong_url =
      base_url + "api/delete_business_latlong";
  static const String list_business_by_name_url =
      base_url + "api/list_business_by_name";
  static const String save_user_token_url = base_url + "api/save_user_token";
  static const String add_unregistered_business_url =
      base_url + "api/add_unregistered_business";
  static const String add_business_time_url =
      base_url + "api/add_business_time";
  static const String search_by_city_url = base_url + "api/search_by_city";
  static const String user_by_id_with_token_url =
      "${base_url}api/user_by_id_with_token";
  static const String send_otp_by_id_url = base_url + "api/send_otp_by_id";
  static const String verify_otp_by_id_url = base_url + "api/verify_otp_by_id";

  static const String terms_service_url = "https://trendsee.app/terms/";
  static const String privacy_policy_url = "https://trendsee.app/privacy/";
  static const String msa_url = "https://trendsee.app/msa/";
  static const String business_error_email = "help@trendsee.app";
  static const String admin_trendsee_email = "admin@trendsee.app";
}
