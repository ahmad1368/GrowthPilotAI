const { execSync } = require("child_process");

try {
  // Run TypeScript compiler and automated test suites
  execSync("npx tsc --noEmit && npm run test", { stdio: "pipe" });
  process.exit(0);
} catch (error) {
  // Capture errors from linter/compiler and feed back to Claude immediately
  console.error("\n[COMPILER/TEST ERRORS DETECTED]:");
  console.error(error.stdout ? error.stdout.toString() : error.message);
  console.error(
    "\n👉 Action Required: Fix these type/test mismatches in all affected files.",
  );
  process.exit(2); // Code 2 blocks Claude and forces a correction cycle
}
