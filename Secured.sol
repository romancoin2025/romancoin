// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

/// @title Secured
/// @author Smithii

import {IERC20AntiBot} from "../interfaces/services/IERC20AntiBot.sol";

/// errors
error BotDetected();

abstract contract Secured {
    address public antiBot = address(0);
    mapping(address => bool) public antiBotExemptions;
    constructor(address _antiBot) {
        antiBot = _antiBot;
    }
    modifier noBots(address _from) {
        if (!antiBotExemptions[_from]) {
           if (IERC20AntiBot(antiBot).isBotDetected(_from)) revert BotDetected();
        }
        _;
    }
    /// Registers the block number of the receiver
    /// @param _to the address to register
    function registerBlock(address _to) internal {
        IERC20AntiBot(antiBot).registerBlock(_to);
    }
    /// globally sets the exemptions
    /// @param _exemptions the addresses to set as exemptions
    function _setAntiBotExemptions(address[] memory _exemptions) internal {
        for (uint256 i = 0; i < _exemptions.length; i++) {
            antiBotExemptions[_exemptions[i]] = true;
        }
    }
}
