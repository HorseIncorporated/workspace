# Claude Configuration Guide

## Build/Test/Lint Commands
- npm run build: Compile TypeScript
- npm run lint: Run ESLint with zero warnings
- npm run lint:fix: Auto-fix ESLint issues
- npm run lint:unused: Remove unused imports  
- npm run format: Run lint:fix and lint:unused
- npm run test: Run all tests
- npm run test -- -t "test name": Run single test

## Code Style Guidelines
- Use TypeScript for type safety
- Prefer named exports over default exports
- Sort imports alphabetically in groups (built-in, external, internal)
- Use async/await over Promises
- Use consistent error handling with try/catch blocks
- Follow semantic naming: nouns for classes/interfaces, verbs for functions
- Comments should explain "why" not "what"
- Maximum line length: 100 characters
- Use camelCase for variables/functions, PascalCase for classes/interfaces
- Always handle Promise rejections
- Don't commit directly to main branch