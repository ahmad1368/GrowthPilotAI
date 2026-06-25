const fs = require("fs");

// ۱. خواندن داده‌های ارسالی از سمت کلود (stdin)
let inputData = "";
process.stdin.on("data", (chunk) => {
  inputData += chunk;
});

process.stdin.on("end", () => {
  try {
    const payload = JSON.parse(inputData);
    const toolName = payload.tool_name;

    // استخراج مسیر فایلی که کلود می‌خواهد به آن دست بزند
    let targetedFile = "";
    if (payload.tool_input) {
      targetedFile =
        payload.tool_input.file_path || payload.tool_input.pattern || "";
    }

    // ۲. لیست فایلهای ممنوعه پروژه شما
    const blackList = [".env", "objectbox-model.json", "secrets"];

    // ۳. بررسی اینکه آیا کلود دارد به فایل ممنوعه نزدیک می‌شود؟
    const isDangerous = blackList.some((blockedItem) =>
      targetedFile.includes(blockedItem),
    );

    if (isDangerous && (toolName === "Read" || toolName === "Grep")) {
      // خطای قرمز برای فرستادن به کلود
      process.stderr.write(
        `[SECURITY ALERT] Access to ${targetedFile} is strictly blocked by GrowthPilotAI Guard.\n`,
      );
      process.exit(2); // کد خروج ۲ یعنی: بلاک کن!
    }

    // اگر مشکلی نبود، اجازه بده اجرا شود
    process.exit(0); // کد خروج ۰ یعنی: آزاد است!
  } catch (e) {
    process.exit(0); // در صورت خطای اسکریپت، برای قفل نشدن کار اجازه عبور بده
  }
});
