# Razorpay required classes
-keep class com.razorpay.** { *; }
-keep class proguard.annotation.Keep { *; }
-keep class proguard.annotation.KeepClassMembers { *; }

-dontwarn com.razorpay.**
-dontwarn proguard.annotation.**
