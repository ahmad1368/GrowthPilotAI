---
description: Pick the next GitHub issue (by logical dependency order), implement it on a new branch, test/QA it, open a PR, and post an English report — then stop. Token-optimized.
---

نقش: دولوپر ارشد GrowthPilotAI. ریپو: https://github.com/ahmad1368/GrowthPilotAI
لوکال: D:\Ahmad Resume Local\Projects GitHub\GrowthPilotAI
آرگومان‌ها: $ARGUMENTS — اگر شامل `--refresh` بود، مرحله ۱ (چک کش) رو نادیده بگیر و همیشه تحلیل کامل (مرحله ۲) رو اجرا کن.

## قوانین صرفه‌جویی توکن (این بخش بر همه‌چیز حاکمه)
- خروجی چت مینیمال: بدون narration مرحله‌به‌مرحله، بدون تکرار این قوانین در پاسخ. فقط پیام‌های کوتاه ۱ خطی در نقاط کلیدی + خلاصه پایانی.
- هیچ فایلی رو دوباره Read نکن اگر همین اجرا قبلاً خوندیش.
- به‌جای کاوش گسترده در کل ریپو، مستقیم سراغ فایل‌های مرتبط با ایشیو انتخابی برو (Grep/Glob هدفمند، نه اکسپلور کامل درخت پروژه).
- برای انتخاب ایشیو فقط از `gh issue list`/`gh pr list` استفاده کن (متن ساده)؛ مرورگر یا اسکرین‌شات لازم نیست تا مرحله QA.
- Subagent فقط اگر واقعاً کار مستقل و موازی‌پذیر باشه؛ برای این پایپلاین معمولاً لازم نیست.
- `flutter analyze` رو فقط یک‌بار در انتها اجرا کن، نه بعد از هر فایل. `flutter test` رو در این پایپلاین اصلاً اجرا نکن (نه کل سوئیت، نه فایل‌های تست جدید) — فقط فایل تست رو بنویس و کنارش بذار؛ اجرای تست‌ها یک تصمیم/تسک جدا از کاربره که خودش هروقت خواست دستی انجام می‌ده.
- اسکرین‌شات فقط از صفحه(های) واقعاً تغییر‌یافته، هر کدام یک بار لایت + یک بار دارک (نه بیشتر، نه صفحات دست‌نخورده).
- تحلیل «چرا این ایشیو» رو فقط ۲-۳ خط در بدنه PR بنویس، نه به‌صورت مکالمه‌ی مفصل در چت.
- دستورات git/gh مرتبط رو تا حد امکان در یک فراخوانی ترمینال بچین (مثلاً add+commit پشت‌سرهم) به‌جای چند تول‌کال جدا.

## مراحل
0. **آماده‌سازی**: `git status` تمیز باشه → `git checkout stage` → `git pull origin stage` (برنچ پایه‌ی همه‌چیز از الان `stage` هست، نه `main`).
1. **کش انتخاب ایشیو (جلوگیری از هزینه‌ی تکراری)**: فایل `.claude/next-issue-cache.json` رو چک کن.
   - اول یک fingerprint سبک بگیر (فقط شماره/تاریخ/عنوان، نه بدنه/کامنت):
     `gh issue list --repo ahmad1368/GrowthPilotAI --state open --json number,updatedAt,title`
   - اگر کش وجود داره، `queue` توش خالی نیست، و آرایه‌ی `snapshot` توش دقیقاً با fingerprint فعلی یکیه
     (همون شماره‌ها + همون updatedAt) و آرگومان `--refresh` هم داده نشده →
     **تحلیل کامل رو رد کن**، مستقیم برو مرحله ۳ و اولین آیتم `queue` رو بردار.
   - در غیر این صورت (کش نیست/خالیه، fingerprint فرق کرده یعنی ایشیو جدید/ویرایش‌شده/بسته‌شده هست،
     یا کاربر `--refresh` داده) → مرحله ۲ (تحلیل کامل) رو اجرا کن و کش رو با ساختار زیر بازنویسی کن:
     ```json
     {
       "generated_at": "<ISO time>",
       "snapshot": [{"number":12,"updatedAt":"...","title":"..."}],
       "queue": [{"number":12,"reason":"..."},{"number":7,"reason":"..."}]
     }
     ```
2. **تحلیل کامل (فقط وقتی کش نامعتبره)**: بدنه/لیبل/کامنت تمام ایشیوهای باز رو بخون، `gh pr list --base stage --state all` رو هم ببین تا چیزهایی که قبلاً پیاده‌سازی/در دست PR هستن رو کنار بذاری، بر اساس وابستگی منطقی (نه شماره/تاریخ) کل صف اولویت رو بساز و در `queue` کش ذخیره کن.
3. **انتخاب ایشیو**: اولین آیتم `queue` (از کش تازه یا معتبر) رو برای این اجرا بردار. بلافاصله همون آیتم رو از آرایه‌ی `queue` در فایل کش حذف و فایل رو ذخیره کن (تا اجرای بعدی سراغش نره، حتی اگه هنوز روی گیت‌هاب به‌خاطر merge‌نشدنِ PR باز باشه). یک جمله دلیل انتخاب کافیه.
4. **برنچ**: `issue-<شماره>-<slug-انگلیسی>` از `stage` (نه از main).
5. **پیاده‌سازی** — الزامات معماری (چک‌لیست، بدون توضیح اضافه در حین کار):
   - هر فایل حداکثر ۵۰ خط؛ منطق سنگین → فایل‌های SRP جدا.
   - مسیرها: `lib/core/interfaces/` (interfaces) · `business/` (usecases) · `controllers/` (GetX) · `lib/core/models/` (entities/ObjectBox/mappers) · `validators/` · `routes/`.
   - فقط تایپوگرافی native `shadcn_ui`؛ ممنوع: AdaptiveText، ShadText سفارشی.
   - `withValues` به‌جای `withOpacity`.
   - اگر به این‌ها برخوردی در مسیر تغییر، حذف/جایگزین با معادل shadcn_ui: `OmniAlertDialog`, `OmniGlassPanel`, `OcrActionButtons`, `omni_button.dart`, `glass_app_bar.dart`, `AdaptiveText`, `omni_logger.dart`. خارج از scope فقط در PR لیست کن، دست نزن.
   - بدون Glassmorphism/BackdropFilter؛ ظاهر flat مینیمال (سبک OpenAI/Claude/Vercel).
   - تم: دارک bg `#09090b` / card `#18181b`؛ لایت bg `#ffffff` / card سفید+سایه ملایم؛ متن و آیکون هم‌رنگ فورگراند مود فعلی.
   - لایه بیزینس موجود (FinancialAnalyticsProcessor، TransactionController و مشابه) دست‌نخورده بمونه؛ UI فقط مصرف‌کننده.
   - خروجی‌ها با `OmniResult`/`OcrEditableFields`/`OmniResponse`/`OmniFailure&Mapper`.
   - DI فقط از GetIt.
   - مدل دیتابیس جدید → اضافه به ObjectBox entities + اجرای کدجنریتور.
   - لاگ فقط از `lib/core/utils/logger.dart` (شامل کاربر، ویجت/سرویس، timestamp، StackTrace).
   - قبل از ادیت هر فایل موجود، حتماً یک‌بار با Read بخونش؛ کد حدسی روی فایل ندیده ممنوع.
   - **سازگاری با build وب (Vercel)**: پروژه با `flutter build web` روی Vercel هم دیپلوی می‌شه، پس هر کدی که فقط native/موبایل باشه (`dart:io`، بایندینگ‌های نیتیو ObjectBox، متدهای پلتفرمی `path_provider`/`image_picker`/`permission_handler` و مشابه، یا هر پکیجی که پیاده‌سازی وب نداره) باید با `kIsWeb` (از `package:flutter/foundation.dart`) گارد بشه و یک مسیر جایگزین/fallback امن برای وب داشته باشه — نه این‌که بدون گارد کامپایل وب رو بشکنه. اگر یک قابلیت اصلاً روی وب معنا نداره (مثلاً دسترسی به فایل‌سیستم نیتیو)، پشت `if (kIsWeb) { ... } else { ... }` مخفی و در وب یک حالت no-op/پیام مناسب نشون بده، نه کرش یا خطای کامپایل.
   - قبل از باز کردن PR، اگه فایلی که تغییر دادی احتمال داره روی وب کامپایل نشه، حتماً `flutter build web --release` رو هم (علاوه بر analyze/test) یک‌بار لوکال امتحان کن؛ خطای کامپایل وب را رفع کن.
6. **تست**: فایل Unit test جدا با نام صریح در `test/` برای منطق جدید.
7. **بررسی نهایی**: یک‌بار `flutter analyze` (کامل) اجرا کن؛ `flutter test` رو اجرا نکن (کاربر خودش جدا هروقت تصمیم گرفت اجرا می‌کنه). اگر فایل‌های تغییر‌یافته احتمال ناسازگاری با وب دارن (پلتفرم-محور/native) یک‌بار `flutter build web --release` هم اجرا کن؛ خطا → رفع.
8. **QA بصری**: فقط صفحات تغییر‌یافته، لایت+دارک، هر کدام یک اسکرین‌شات؛ چک سریع overflow در عرض موبایل/دسکتاپ.
9. **کامیت/پوش/PR**: کامیت انگلیسی → push → `gh pr create --base stage` (فقط به `stage`، هرگز مستقیم به `main`؛ بدون merge خودکار) → روی همون PR ریپورت انگلیسی کوتاه:
   ```
   ## Summary
   - Why this issue now (1-3 lines)
   - What changed (files, paths)
   - Legacy widgets removed/replaced (if any)
   - Tests added (not executed — run `flutter test` manually when ready)
   - analyze result
   ## Screenshots
   ## Notes (open follow-ups for future issues)
   ```
10. **پایان**: بعد از باز شدن PR متوقف شو. خروجی نهایی چت: فقط شماره ایشیو، نام برنچ، لینک PR.
