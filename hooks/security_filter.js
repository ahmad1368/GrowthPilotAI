process.stdin.setEncoding("utf8");
let input = "";

process.stdin.on("data", (chunk) => {
  input += chunk;
});

process.stdin.on("end", () => {
  try {
    const payload = JSON.parse(input);
    const toolName = payload.tool_name;
    const args = payload.tool_input || {};

    // لیست کلمات کلیدی و فایل‌های خط قرمز پروژه شما
    const sensitiveItems = [".env", "objectbox-model.json", "secrets"];

    let isViolation = false;
    let alertMessage = "";

    // ۱. بررسی ابزار Read (خوانش مستقیم فایل)
    if (toolName === "Read") {
      const filePath = args.file_path || "";
      if (sensitiveItems.some((item) => filePath.includes(item))) {
        isViolation = true;
        alertMessage = `Directly reading sensitive files (${filePath}) is prohibited.`;
      }
    }

    // ۲. بررسی ابزار Grep (جستجوی متنی درون فایل‌ها)
    else if (toolName === "Grep") {
      const pattern = args.pattern || "";
      const path = args.path || "";
      // اگر بخواهد کلماتی مثل .env را سرچ کند یا درون پوشه حساس بگردد
      if (
        sensitiveItems.some(
          (item) => pattern.includes(item) || path.includes(item),
        )
      ) {
        isViolation = true;
        alertMessage = `Searching inside sensitive paths/patterns is prohibited.`;
      }
    }

    // ۳. بررسی ابزار Bash (اجرای دستوراتی مثل cat .env یا rm -rf)
    else if (toolName === "Bash") {
      const command = args.command || "";
      // بررسی اینکه آیا دستور ترمینال شامل فایل‌های حساس هست یا خیر
      if (sensitiveItems.some((item) => command.includes(item))) {
        isViolation = true;
        alertMessage = `Running terminal commands accessing sensitive files is prohibited.`;
      }
    }

    // اعمال قانون: اگر تخلفی صورت گرفته، کلود را بلاک کن
    if (isViolation) {
      console.error(`\n[SECURITY BREACH DETECTED]: ${alertMessage}`);
      process.exit(2); // کد خروج ۲ یعنی بلاک کردن عملیات کلود
    }

    // عبور امن در صورت نبود مشکل
    process.exit(0);
  } catch (e) {
    // در صورت بروز خطای غیرمنتظره در اسکریپت، برای قفل نشدن کلود اجازه عبور می‌دهیم
    process.exit(0);
  }
});
