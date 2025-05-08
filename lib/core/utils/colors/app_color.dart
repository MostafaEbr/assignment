import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  static const Color WHITE_COLOR = Color(0xffFFFFFF);
  static const Color BLACK_COLOR = Color(0xff000000);

  static const Color BACKGROUND_COLOR_LIGHT =  Color(0xffFFFFFF);// WHITE_COLOR;
  // static const Color BACKGROUND_COLOR_LIGHT =  Color(0xfff9f9f9);// WHITE_COLOR;
  static const Color BACKGROUND_COLOR_DARK = Color(0xffFAF9F6);



  // static const Color PRIMARY_COLOR = Color(0xff007B62);

  static const Color PRIMARY_COLOR = Color(0xffFF5215);//FF5215  //FA5A2A used First
  // static const Color PRIMARY_COLOR = Color(0xff1C2E4A);
  static const Color IMPERIAL_PRIMER = Color(0xff222f3e);

  static const Color ON_PRIMARY_COLOR = Color(0xffFFFFFF);

  static const Color SECONDARY_COLOR = Color(0xffE2E2B6);
  static const Color SECONDARY_YELLOW_COLOR = Color(0xffFFD700);
  static const Color SECONDARY_ORANGE_COLOR = Color(0xffff7643);
  static const Color ON_SECONDARY_COLOR = Color(0xffFFFFFF);


  static const Color ACCENT_COLOR = Color(0xffB00020);

  static const Color GREY_COLOR_33 = Color(0xff333333);
  static const Color GREY_COLOR_99 = Color(0xff999999);
  static const Color GREY_COLOR_64 = Color(0xff646464);
  static const Color GREY_COLOR_F4 = Color(0xffF4F4F4);
  static const Color GREY_COLOR_F9 = Color(0xffF5F6F9);
  static const Color GREY_COLOR_FA = Color(0xffFAFAFA);

  static const Color GREY_COLOR = Color(0xff808080);
  static const Color GREY_COLOR_18 = Color(0xff181818);
  static const Color GREY_COLOR_35 = Color(0xff373735);
  static const Color GREY_COLOR_E5 = Color(0xffe5e5e5);
  static const Color GREY_COLOR_48 = Color(0xff484848);
  static const Color GREY_COLOR_42 = Color(0xff424242);
  static const Color GREY_COLOR_a7 = Color(0xff8395a7);
  static const Color GREY_COLOR_D5 = Color(0xffD5D5D5);
  static const Color GREY_COLOR_ED = Color(0xfff1f1ef);
  static const Color GREY_COLOR_89 = Color(0xff868889);
  static const Color GREY_COLOR_A3 = Color(0xff9098A3);


// Status-Specific Colors
  static const Color STATUS_PENDING = Color(0xffFFA726);      // Orange for Pending
  static const Color STATUS_CONFIRMED = Color(0xff29B6F6);    // Blue for Confirmed
  static const Color STATUS_SHIPPED = Color(0xffAB47BC);      // Purple for Shipped
  static const Color STATUS_DELIVERED = Color(0xff66BB6A);    // Green for Delivered
  static const Color STATUS_CANCELED = Color(0xffEF5350);     // Red for Canceled
  static const Color STATUS_COMPLETED = Color(0xff4CAF50);    // Dark Green for Completed
  static const Color STATUS_DONE = Color(0xff8D6E63);         // Brown for Done
  static const Color STATUS_FAILED = Color(0xffD32F2F);       // Dark Red for Failed
  static const Color STATUS_PAID = Color(0xffFFD700);         // Gold for Paid

  // Method to Get Status Color
  static Color getStatusColor(int status) {
    switch (status) {
      case 300: // PENDING
        return STATUS_PENDING;
      case 302: // CONFIRMED
        return STATUS_CONFIRMED;
      case 303: // SHIPPED
        return STATUS_SHIPPED;
      case 304: // DELIVERED
        return STATUS_DELIVERED;
      case 305: // CANCELED
        return STATUS_CANCELED;
      case 307: // COMPLETED
        return STATUS_COMPLETED;
      case 301: // DONE
        return STATUS_DONE;
      case 306: // FAILED
        return STATUS_FAILED;
      case 308: // PAID
        return STATUS_PAID;
      default:
        return GREY_COLOR_99; // Default color for unknown status
    }
  }

}