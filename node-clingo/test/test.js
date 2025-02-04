const clingo = require("../lib");
const path = require("path");
const fs = require("fs");

async function test() {
  // loop 10 times
  try {
    const mainLp = path.resolve(__dirname, "../calc/main.lp");
    const treeLp = path.resolve(__dirname, "../tree.lp");

    const queryLp = path.resolve(__dirname, "../queryLanguage.lp");

    const result = await clingo.solve({
      files: [mainLp, treeLp, queryLp],
    });

    // write the answers to a file
    fs.writeFileSync("answers.txt", result.answers.join("\n"));
  } catch (error) {
    console.error("Error:", error.message);
    console.error("Stack:", error.stack);
  }
}

test();
