const clingo = require('../lib');
const path = require('path');
const fs = require('fs');

async function test() {
    try {
        const mainLp = path.resolve(__dirname, '../calc/main.lp');
        const treeLp = path.resolve(__dirname, '../tree.lp');
        
        const result = await clingo.solve({
            files: [mainLp, treeLp]
        });
        
        console.log(`\nC++ interaction time: ${result.cppExecutionTime}ms`);
        console.log(`Total execution time: ${result.totalTime}ms`);
        console.log(`Number of answer sets: ${result.answers.length}`);
        console.log('\nAnswer sets:');
        result.answers.forEach((answer, i) => {
            console.log(`${i + 1}: ${answer}`);
        });
    } catch (error) {
        console.error('Error:', error.message);
        console.error('Stack:', error.stack);
    }
}

test(); 