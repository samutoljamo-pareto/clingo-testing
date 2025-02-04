const clingo = require("../lib");
const path = require("path");
const fs = require("fs");

async function test() {
  try {
    const treeLp = path.resolve(__dirname, "../test.lp");

    const result = await clingo.solve({
      files: [treeLp],
    });
  } catch (error) {
    console.error("Error:", error.message);
    console.error("Stack:", error.stack);
  }
}

test();
