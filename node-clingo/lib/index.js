const binding = require("bindings")("node-clingo");
const fs = require("fs");
const path = require("path");

/**
 * Reads a logic program file and resolves any includes
 * @param {string} filePath - Path to the logic program file
 * @param {Set<string>} included - Set of already included files to prevent cycles
 * @returns {string} The complete program with includes resolved
 */
function readProgramFile(filePath, included = new Set()) {
  if (included.has(filePath)) {
    return ""; // Skip if already included
  }
  included.add(filePath);

  try {
    console.log(`Reading file: ${filePath}`);
    const content = fs.readFileSync(filePath, "utf8");
    const dir = path.dirname(filePath);

    // Replace #include statements with the actual content, preserving the trailing dot if any
    return content.replace(
      /#include\s*"([^"]+)"(\s*\.)?/g,
      (match, includePath) => {
        const fullPath = path.resolve(dir, includePath);
        console.log(`Including file: ${fullPath}`);
        try {
          return readProgramFile(fullPath, included);
        } catch (error) {
          console.error(
            `Error reading included file ${fullPath}: ${error.message}`
          );
          throw error;
        }
      }
    );
  } catch (error) {
    console.error(`Error reading file ${filePath}: ${error.message}`);
    throw error;
  }
}

/**
 * Solves a logic program
 * @param {Object} options - Options for solving
 * @param {string} [options.program] - Additional logic program as a string
 * @param {string} [options.file] - Path to the main logic program file
 * @param {string[]} [options.files] - Additional logic program files to include
 * @param {string[]} [options.args] - Command line arguments for clingo
 * @returns {Promise<Object>} Object containing answers and execution time
 */
async function solve(options = {}) {
  let program = "";

  // Read the main file if provided
  if (options.file) {
    try {
      program = readProgramFile(options.file);
    } catch (error) {
      console.error("Error reading main program file:", error);
      throw error;
    }
  }

  // Read additional files if provided
  if (options.files) {
    for (const file of options.files) {
      try {
        program += "\n" + readProgramFile(file);
      } catch (error) {
        console.error(`Error reading additional file ${file}:`, error);
        throw error;
      }
    }
  }

  // Add additional program if provided
  if (options.program) {
    program += "\n" + options.program;
  }

  if (!program) {
    throw new Error("No program provided");
  }

  // Write the complete program to a debug file
  const debugFile = path.resolve(__dirname, "debug.lp");
  fs.writeFileSync(debugFile, program);

  try {
    // Measure time for C++ interaction
    const startTime = process.hrtime.bigint();
    const result = binding.solve(program, options.args || []);
    const endTime = process.hrtime.bigint();
    const cppTime = Number(endTime - startTime) / 1_000_000; // Convert to milliseconds

    console.log(`C++ interaction time: ${cppTime}ms`);
    console.log(`Total execution time: ${result.executionTime}ms`);
    console.log(`Number of answer sets: ${result.answers.length}`);
    console.log("\nAnswer sets:");
    result.answers.forEach((answer, i) => {
      console.log(`${i + 1}: ${answer}`);
    });
    return result;
  } catch (error) {
    console.error("Error solving program:", error);
    throw error;
  }
}

module.exports = {
  solve,
};
