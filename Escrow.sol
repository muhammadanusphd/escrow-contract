// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title Simple Escrow Contract for buyer & seller
/// @notice Holds funds until buyer confirms delivery or cancels
contract Escrow {
    address public buyer;
    address payable public seller;
    address public arbiter; // optional third party (can approve release)

    uint256 public amount;
    bool public isFunded;
    bool public isReleased;
    bool public isCancelled;

    constructor(address _buyer, address payable _seller, address _arbiter) payable {
        require(msg.value > 0, "Must fund escrow on creation");
        buyer = _buyer;
        seller = _seller;
        arbiter = _arbiter;
        amount = msg.value;
        isFunded = true;
    }

    modifier onlyBuyer() {
        require(msg.sender == buyer, "Only buyer allowed");
        _;
    }

    modifier onlyArbiter() {
        require(msg.sender == arbiter, "Only arbiter allowed");
        _;
    }

    modifier notReleased() {
        require(!isReleased, "Funds already released");
        _;
    }

    modifier notCancelled() {
        require(!isCancelled, "Escrow cancelled");
        _;
    }

    /// @notice Buyer confirms delivery and releases funds to seller
    function release() external onlyBuyer notReleased notCancelled {
        isReleased = true;
        (bool sent, ) = seller.call{value: amount}("");
        require(sent, "Failed to send funds");
    }

    /// @notice Buyer cancels the purchase and refunds themselves
    function cancel() external onlyBuyer notReleased notCancelled {
        isCancelled = true;
        (bool sent, ) = payable(buyer).call{value: amount}("");
        require(sent, "Failed to refund buyer");
    }

    /// @notice Arbiter can release funds if buyer/seller disagree
    function arbiterRelease() external onlyArbiter notReleased notCancelled {
        isReleased = true;
        (bool sent, ) = seller.call{value: amount}("");
        require(sent, "Failed to send funds");
    }
}
