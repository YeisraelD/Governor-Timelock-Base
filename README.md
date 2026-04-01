# 🏛️ Governor Timelock Base

A robust, modular, and secure DAO infrastructure built with **Foundry** and **OpenZeppelin Contracts v5.x**. This repository implements the "Trustless Loop" architecture, featuring a governance token, a governor contract, and a timelock controller.

---

## 🏗️ Architecture

This DAO setup follows the standard OpenZeppelin governance pattern:

1.  **Governance Token (`GovernanceToken.sol`)**: An ERC20 token with `ERC20Votes` extension. It tracks voting power through checkpoints, preventing flash-loan attacks or swing-voting.
2.  **Governor Contract (`GovernorContract.sol`)**: The "Brain" of the DAO. It handles proposal creation, voting logic, and quorum verification. It is configured with `GovernorSettings`, `GovernorCountingSimple`, and `GovernorTimelockControl`.
3.  **Timelock Controller (`TimeLock.sol`)**: The "Vault" and "Executor." It holds all DAO-controlled assets and enforces a mandatory delay (e.g., 1 hour) before successful proposals can be executed, giving users a final exit window.

---

## 🚀 Getting Started

### Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation) installed.

### Installation

```bash
git clone https://github.com/YeisraelD/Governor-Timelock-Base.git
cd Governor-Timelock-Base
forge install
```

### Build

```bash
forge build
```

### Test

```bash
forge test
```

---

## 📜 Contract Details

### Governor Settings
- **Voting Delay**: 1 block (~12 seconds)
- **Voting Period**: 50,400 blocks (~1 week)
- **Proposal Threshold**: 0 tokens (can be updated via governance)
- **Quorum**: 4% of total supply

---

## 🛠️ Usage

### Proposing a Change
Proposals are made through the `GovernorContract`. A proposer must have sufficient voting power (as defined by `proposalThreshold`).

### Voting
Once the `votingDelay` has passed, token holders can cast their votes (`For`, `Against`, or `Abstain`).

### Queuing & Execution
If a proposal passes and meets the quorum, it must be **queued** in the `TimeLock`. After the `minDelay` expires, anyone can **execute** the proposal.

---

## 🛡️ Security

This project uses **OpenZeppelin 5.x** contracts, ensuring high security standards. The architecture ensures that the Governor contract is the only entity that can propose actions to the Timelock, while the Timelock is the only entity that can execute those actions.

---

## 🎨 Visual Semantics (Technical Emoji Implementation)

To enhance developer experience (DX) and provide immediate visual context, this repository adopts a **Metadata-Rich Documentation Standard** using Unicode 15.1 glyphs.

### Why Emojis in Technical Docs?

1.  **Cognitive Load Reduction**: Emojis serve as "visual anchors," allowing developers to scan the README for sections like `Security` or `Installation` in <500ms.
2.  **State Representation**:
    -   🏛️ **Governance**: Represents the structural and legal framework.
    -   🏗️ **Architecture**: Represents the build-phase and technical stack.
    -   🚀 **Deployment**: High-velocity action, moving from staging to mainnet.
    -   🛡️ **Security**: Defensive posture, indicating protected or audited code.
3.  **Cross-Platform Consistency**: Emojis are processed as 4-byte UTF-8 sequences, ensuring logical consistency across IDEs (VS Code), Terminals (Foundry/Anvil), and Version Control (GitHub).

### Unicode Processing
All documentation in this repo is encoded in `UTF-8`. Emojis are treated as high-order code points, specifically in the `Miscellaneous Symbols and Pictographs` block (`U+1F300` through `U+1F5FF`).

---

## 📄 License
This project is licensed under the **MIT License**.
