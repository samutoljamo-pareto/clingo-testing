# node-clingo

Node.js bindings for the Clingo answer set solver.

## Prerequisites

Before installing this package, make sure you have the following dependencies installed:

- Node.js (v14 or later recommended)
- npm
- Clingo development files (`libclingo-dev` package on Ubuntu/Debian)
- C++ build tools (gcc/g++ or equivalent)
- Python (for node-gyp)

On Ubuntu/Debian, you can install the prerequisites with:

```bash
sudo apt-get update
sudo apt-get install -y nodejs npm libclingo-dev build-essential python3
```

## Installation

```bash
npm install node-clingo
```

## Usage

```javascript
const clingo = require('node-clingo');

async function main() {
    try {
        // Define your logic program as a string
        const program = `
            num(1..3).
            { selected(X) } :- num(X).
            :- not selected(_).
        `;
        
        // Solve the program
        const answers = await clingo.solve(program);
        
        // Print the answer sets
        answers.forEach((answer, index) => {
            console.log(`Answer set ${index + 1}: ${answer}`);
        });
    } catch (error) {
        console.error('Error:', error.message);
    }
}

main();
```

## API

### solve(program: string): Promise<string[]>

Solves the given logic program and returns a promise that resolves to an array of answer sets.

- `program`: A string containing the logic program in ASP syntax
- Returns: A promise that resolves to an array of strings, where each string represents an answer set

## Error Handling

The `solve` function will reject the promise with an error if:
- The input program is invalid
- There's a syntax error in the program
- The solver encounters any other error during execution

## License

MIT 