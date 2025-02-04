const fs = require("fs");
const path = require("path");

// Function to recursively find all .lp files
function findLpFiles(dir, fileList = []) {
  try {
    const files = fs.readdirSync(dir);

    files.forEach((file) => {
      const filePath = path.join(dir, file);
      const stat = fs.statSync(filePath);

      if (stat.isDirectory()) {
        findLpFiles(filePath, fileList);
      } else if (path.extname(file) === ".lp") {
        fileList.push(filePath);
      }
    });
  } catch (error) {
    console.error(`Error reading directory ${dir}:`, error.message);
  }

  return fileList;
}

// Function to convert WSL path to relative path
function convertToRelativePath(wslPath) {
  // Handle paths with /resources/
  if (wslPath.includes("/resources/")) {
    return wslPath.replace(
      /^\/home\/[^/]+\/projects\/[^/]+\/\.calc\/resources\//,
      "resources/"
    );
  }
  // Handle paths with /cards/
  else if (wslPath.includes("/cards/")) {
    return wslPath.replace(
      /^\/home\/[^/]+\/projects\/[^/]+\/\.calc\/cards\//,
      "cards/"
    );
  }
  // Handle other paths under .calc
  else {
    return wslPath.replace(/^\/home\/[^/]+\/projects\/[^/]+\/\.calc\//, "");
  }
}

// Function to ensure directory exists
function ensureDirectoryExists(dirPath) {
  if (!fs.existsSync(dirPath)) {
    console.log("Creating directory:", dirPath);
    fs.mkdirSync(dirPath, { recursive: true });
  }
}

// Function to fix include paths in a file
function fixIncludePaths(filePath) {
  try {
    let content = fs.readFileSync(filePath, "utf8");
    let modified = false;

    // Find all #include statements with WSL paths
    const includeRegex = /#include\s*"([^"]+)"/g;
    const wslPathRegex = /^\/home\/[^/]+\/projects\/[^/]+\/\.calc\//;

    content = content.replace(includeRegex, (match, includePath) => {
      if (wslPathRegex.test(includePath)) {
        modified = true;
        const relativePath = convertToRelativePath(includePath);

        // Create the directory for the included file if it doesn't exist
        const includedFileDir = path.dirname(
          path.resolve(path.dirname(filePath), relativePath)
        );
        ensureDirectoryExists(includedFileDir);

        return `#include "${relativePath}"`;
      }
      return match;
    });

    if (modified) {
      console.log(`Fixing includes in: ${filePath}`);
      console.log("Modified content:", content);
      fs.writeFileSync(filePath, content, "utf8");
    }
  } catch (error) {
    console.error(`Error processing file ${filePath}:`, error.message);
  }
}

// Main function
function main() {
  try {
    const calcDir = path.resolve(__dirname, "../calc");

    // Create necessary base directories
    const directories = [
      path.join(calcDir, "resources"),
      path.join(calcDir, "resources/base"),
      path.join(calcDir, "resources/base/cardTypes"),
      path.join(calcDir, "resources/base/fieldTypes"),
      path.join(calcDir, "resources/base/linkTypes"),
      path.join(calcDir, "resources/base/workflows"),
      path.join(calcDir, "cards"),
    ];

    directories.forEach((dir) => ensureDirectoryExists(dir));

    console.log("Searching for .lp files in:", calcDir);
    const lpFiles = findLpFiles(calcDir);
    console.log(`Found ${lpFiles.length} .lp files`);

    lpFiles.forEach((file) => {
      fixIncludePaths(file);
    });

    console.log("Done fixing include paths");
  } catch (error) {
    console.error("Error in main function:", error.message);
  }
}

main();
