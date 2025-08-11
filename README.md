# Escrow Contract

This smart contract holds funds in escrow for a buyer and seller transaction. The buyer funds the contract on creation. Funds are released to the seller when the buyer confirms delivery or via an arbiter in case of disputes. Buyer can also cancel to get a refund.

---

## Repo contents

- `Escrow.sol` — Solidity contract
- `.gitignore` — basic ignores
- `LICENSE` — MIT

---

## How it works

- **Buyer:** Funds the escrow contract at deployment.
- **Seller:** Receives funds upon buyer confirmation or arbiter decision.
- **Arbiter:** Optional trusted third party to resolve disputes.

---

## How to test in Remix

1. Open https://remix.ethereum.org  
2. Create `Escrow.sol` and paste the code  
3. Compile with Solidity 0.8.x  
4. Deploy contract:
   - Environment: `Remix VM (London)`
   - Input constructor parameters:
     - `_buyer`: pick buyer address (e.g. `0x5B3...`)
     - `_seller`: pick seller address (payable)
     - `_arbiter`: optional arbiter address (or use buyer if none)
   - Fund the contract by setting **Value** (ETH) > 0 (e.g. 1 ETH)
5. Deploy and confirm deployment

---

## Test functions

- **release()**: called by buyer to send funds to seller.
- **cancel()**: called by buyer to refund themselves.
- **arbiterRelease()**: called by arbiter to release funds to seller in disputes.

---

## Notes

- Always fund the contract on creation with ETH (value > 0).
- The contract currently only supports one transaction per deployment.
- Can be extended for multi-transaction escrow.

---

## License
MIT
