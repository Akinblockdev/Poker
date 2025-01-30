# Decentralized Poker Smart Contract Project

A decentralized poker game implementation using Clarity smart contracts on the Stacks blockchain. This project implements a trustless, verifiable poker game where players can participate in Texas Hold'em matches with guaranteed fairness and transparency.

## Project Overview

The project is structured as a series of interconnected smart contracts that handle different aspects of a poker game, from deck management to game logic and prize distribution.

### Project Structure

```
poker-contract/
├── contracts/
│   ├── poker-game.clar          # Main contract handling game flow
│   ├── card-deck.clar           # Card deck generation and management
│   ├── hand-evaluator.clar      # Poker hand evaluation logic
│   └── prize-pool.clar          # Prize pool and betting management
│
├── tests/
│   ├── poker-game_test.ts       # Main contract tests
│   ├── card-deck_test.ts        # Card deck tests
│   ├── hand-evaluator_test.ts   # Hand evaluation tests
│   └── prize-pool_test.ts       # Prize pool tests
│
├── scripts/
│   ├── deploy.ts                # Deployment scripts
│   └── setup-game.ts            # Game setup utilities
│
├── docs/
│   ├── ARCHITECTURE.md          # System architecture
│   ├── GAMEPLAY.md              # Game rules and flow
│   └── TECHNICAL-SPECS.md       # Technical specifications
│
└── README.md                    # Project overview (this file)
```

## Contract Components

### 1. Card Deck Contract (Implemented)
- Manages deck creation and card distribution
- Handles secure card dealing and tracking
- Features:
  - Deck initialization
  - Card dealing mechanics
  - Deck status tracking
  - Security validations
  - Deck retirement functionality

### 2. Poker Game Contract (Planned)
- Manages game flow and player interactions
- Features:
  - Player management
  - Betting rounds
  - Game state transitions
  - Action validation

### 3. Hand Evaluator Contract (Planned)
- Evaluates poker hands and determines winners
- Features:
  - Hand ranking system
  - Combination detection
  - Winner determination

### 4. Prize Pool Contract (Planned)
- Manages betting and prize distribution
- Features:
  - Stake management
  - Prize pool calculations
  - Automated payouts

## Getting Started

### Prerequisites
- Clarity CLI
- Node.js and npm
- Stacks blockchain development environment

### Installation
1. Clone the repository:
```bash
git clone https://github.com/yourusername/poker-contract.git
cd poker-contract
```

2. Install dependencies:
```bash
npm install
```

3. Run tests:
```bash
npm test
```

## Development Status

### Completed:
- ✅ Card Deck Contract
  - Deck initialization
  - Card dealing
  - Status tracking
  - Security measures

### In Progress:
- 🔄 Hand Evaluator Contract
- 🔄 Game Flow Contract
- 🔄 Prize Pool Management

### Planned:
- 📅 Player Registration System
- 📅 Tournament Support
- 📅 Advanced Security Features

## Testing

Each contract component has its own test suite. To run tests for specific components:

```bash
npm run test:card-deck
npm run test:hand-evaluator
npm run test:game-flow
npm run test:prize-pool
```

## Security Considerations

- All critical functions are protected with appropriate access controls
- Random number generation uses blockchain-based entropy
- Anti-cheating mechanisms are implemented
- Timeout protection for player actions
- Emergency withdrawal capabilities

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request