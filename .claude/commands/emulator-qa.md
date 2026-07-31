---
description: On-demand visual QA — launch the Android emulator, build/install/run the app, and screenshot the current state (light + dark). Only runs when the user explicitly invokes it; never called automatically by /next-issue.
---

نقش: QA دستی روی شبیه‌ساز اندروید. لوکال: D:\Ahmad Resume Local\Projects GitHub\GrowthPilotAI
آرگومان‌ها: $ARGUMENTS — توضیح آزاد از این‌که کاربر می‌خواد چی رو ببینه (مثلاً «Business Compass» یا «صفحه تنظیمات») و/یا نام emulator دلخواه (پیش‌فرض `Pixel_7`). اگر خالی بود، فقط صفحه اول اپ (Home) رو اسکرین‌شات بگیر.

## چرا این دستور جدا از `/next-issue` هست
اجرای emulator داخل پایپلاین `/next-issue` کند و ناپایدار بود (بیلد اول Gradle چند دقیقه طول می‌کشه، `flutter run` پشت یک شل بک‌گراند گاهی connection رو گم می‌کنه). این دستور فقط با درخواست مستقیم کاربر اجرا می‌شه، نه خودکار.

## نکات کلیدی (از تجربه‌ی قبلی)
- به‌جای `flutter run` (که resident می‌مونه و پشت شل بک‌گراند ممکنه "Lost connection to device" بده)، از مسیر پایدارتر استفاده کن: `flutter build apk --debug` → `adb install -r` → `adb shell monkey -p com.example.growth_pilot_ai -c android.intent.category.LAUNCHER 1`. این مسیر به یک دیمون زنده وابسته نیست.
- اسکرین‌شات با `adb exec-out screencap -p > <path>.png` بگیر، نه ابزار مرورگر (اپ Flutter نیتیو اندرویده، نه وب).
- بعد از هر اسکرین‌شات حتماً با Read فایل PNG رو ببین (وگرنه کورکورانه tap می‌زنی).
- این اپ deep-link/route آماده برای ناوبری مستقیم نداره؛ تنها راه رسیدن به یک صفحه‌ی خاص، tap زدن روی UI واقعیه (drawer/دکمه‌ها) — کاراکتر مختصات رو از روی همون اسکرین‌شات تخمین بزن، بعد از هر tap دوباره اسکرین‌شات بگیر تا مطمئن شی درست رفتی.
- تغییر تم: آیکون ⚙️ گوشه‌ی بالا-راست روی صفحه‌ی Home (`HomeLayout`/`AppShellBar`) → می‌ره به `/settings` → ویجت `ThemeToggle` اونجاست. صفحات دیگه (مثلاً Business Compass) این آیکون رو ندارن، پس برای عوض کردن تم باید اول با دکمه‌ی Back به Home برگردی، تم رو عوض کنی، بعد دوباره به همون مسیر tap-navigate کنی.

## مراحل
1. **دستگاه**: `adb devices` رو چک کن.
   - اگه device آنلاین نیست: `flutter emulators --launch <نام emulator، پیش‌فرض Pixel_7>` رو بک‌گراند اجرا کن، بعد با یک حلقه‌ی poll (`until adb devices | grep -q "device$"; do sleep 3; done`) صبر کن تا آنلاین بشه (timeout معقول ~120s؛ اگه رد شد به کاربر بگو و متوقف شو، دوباره‌دوباره retry نکن).
2. **بیلد/نصب/اجرا**:
   ```
   flutter build apk --debug
   adb install -r build/app/outputs/flutter-apk/app-debug.apk
   adb shell monkey -p com.example.growth_pilot_ai -c android.intent.category.LAUNCHER 1
   ```
   بعد چند ثانیه صبر کن (یا با `adb logcat` دنبال یک لاگ مشخص از استارتاپ اپ بگرد، مثل `Initialized successfully`) تا مطمئن شی UI رندر شده.
3. **اسکرین‌شات اول (Light یا هر مود پیش‌فرض فعلی)**: `adb exec-out screencap -p > <scratchpad>/qa-1.png` → با Read ببینش.
4. **ناوبری** (فقط اگه $ARGUMENTS صفحه/فیچر خاصی خواسته): با نگاه به اسکرین‌شات، دکمه/آیتم مرتبط رو با `adb shell input tap x y` بزن، دوباره اسکرین‌شات بگیر و چک کن درست رفتی؛ حداکثر چند بار (۳-۴) تلاش کن، اگه نرسیدی به کاربر بگو مسیر رو دستی مشخص کنه.
5. **اسکرین‌شات دوم (Dark)**: طبق نکته‌ی بالا برگرد Home → ⚙️ → `/settings` → بزن روی `ThemeToggle` → دوباره مسیر مرحله ۴ رو برو → اسکرین‌شات بگیر و ببینش.
6. **گزارش**: خلاصه‌ی کوتاه از چیزی که دیدی (overflow؟ رندر درست؟ چیزی کرش کرد؟) + مسیر دو اسکرین‌شات. اسکرین‌شات‌ها رو در `<scratchpad>` نگه‌دار، پاک نکن مگر کاربر بخواد.

## توقف
بعد از گزارش نهایی متوقف شو؛ کامیت/پوش/PR نزن (این دستور فقط QA هست، نه پیاده‌سازی).
