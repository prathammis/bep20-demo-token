// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
   DEMO BEP-20 TOKEN
   ------------------
   This is a demonstration contract for a client.
   Includes:
   - BEP20 standard functions
   - Owner-only mint
   - Owner-only burn
   - Pause/unpause functionality
*/

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DemoToken is ERC20, ERC20Burnable, Pausable, Ownable {
    
    constructor() ERC20("DemoToken", "DEMO") Ownable(msg.sender) {
        // Mint initial supply to deployer (for demo)
        _mint(msg.sender, 1000 * 10**decimals());
    }

    // Owner-only mint function
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Pause transfers
    function pause() public onlyOwner {
        _pause();
    }

    // Unpause transfers
    function unpause() public onlyOwner {
        _unpause();
    }

    // Before token transfer hook
    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal whenNotPaused override
    {
        super._beforeTokenTransfer(from, to, amount);
    }
}
