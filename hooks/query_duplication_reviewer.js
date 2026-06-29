const path = require("path");
process.stdin.setEncoding("utf8");
let input = "";

process.stdin.on("data", (chunk) => {
  input += chunk;
});
process.stdin.on("end", () => {
  try {
    const payload = JSON.parse(input);
    const modifiedFile = payload.tool_input?.file_path || "";

    // Optimization: Focus monitoring only on high-value query/database directories
    if (
      !modifiedFile.includes("lib/core/data/") &&
      !modifiedFile.includes("queries")
    ) {
      process.exit(0); // Skip analysis for non-critical files to save performance/API costs
    }

    // Logic to launch a separate AI instance via Agent SDK goes here
    // Example: const duplicateFound = callSecondaryAIInstance(payload);
    let duplicateFound = false;

    if (duplicateFound) {
      console.error(
        "\n[CODE REVIEW WARNING]: Duplicate query or logic detected by Review-AI.",
      );
      console.error(
        "👉 Action Required: Reuse existing queries instead of writing new ones.",
      );
      process.exit(2);
    }
    process.exit(0);
  } catch (e) {
    process.exit(0);
  }
});
