# Sim IDX Sample Project

**Sim IDX** is a framework that helps you build and deploy applications that index blockchain data in minutes. Define listeners that react to specific onchain events, extract relevant data, and automatically make this data queryable via an API.

This sample project indexes **Uniswap V3 Factory pool creation events** and serves as your starting point for building with Sim IDX.

When you're ready to continue, the [Quickstart guide](https://docs.sim.dune.com/idx) will walk you through authenticating and testing your listener on real data.

## What You'll Edit

The main files and folders you'll work with are:

-   **`abis/`** - Add JSON ABI files for contracts you want to index.
-   **`listeners/src/`** - Define your `Triggers` contract in `Main.sol` and implement your handler logic in one or more listener contracts.
-   **`apis/src/index.ts`** - Define APIs for your indexed data.

## App Structure

```text
.
├── sim.toml                     # App configuration
├── apis/                        # Your custom API code
├── abis/                        # Contract ABI files (JSON)
│   └── UniswapV3Factory.json    # Example: Uniswap V3 Factory ABI
└── listeners/                   # Foundry project for listener contracts
    ├── src/
    │   └── Main.sol             # Triggers contract & listener logic
    └── test/
        └── Main.t.sol           # Unit tests for your listener
```

The `listeners/` directory is a Foundry project where your indexing logic lives. For a detailed breakdown of each file and folder, see the [App Folder Structure](https://docs.sim.dune.com/idx/app-structure) documentation.

## Next Steps

Ready to start building? Check out our comprehensive guides:

-   **[Deploying Your App](https://docs.sim.dune.com/idx/deployment)** - Deploy your app
-   **[Adding ABIs](https://docs.sim.dune.com/idx/cli#sim-abi)** - How to add contract ABIs
-   **[Writing Listeners](https://docs.sim.dune.com/idx/listener)** - Define your indexing logic
-   **[CLI Reference](https://docs.sim.dune.com/idx/cli)** - All available commands