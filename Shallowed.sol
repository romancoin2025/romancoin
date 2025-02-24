// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

/// @title Whale Detector
/// @author Smithii

import {IERC20AntiWhale} from "../interfaces/services/IERC20AntiWhale.sol";

/// errors
error WhaleDetected();

abstract contract Shallowed {
    address public antiWhale = address(0);
    mapping(address => bool) public antiWhaleExemptions;
    mapping(address => bool) public antiWhaleSenderExemptions;
    constructor(address _antiWhale) {
        antiWhale = _antiWhale;
    }
    modifier noWhales(address _to, uint256 _amount) {
        if (!antiWhaleExemptions[_to] && !antiWhaleSenderExemptions[msg.sender]) {
           if (IERC20AntiWhale(antiWhale).isWhaleDetected(_to, _amount))
            revert WhaleDetected();
        }
        _;
    }
    /// Registers the block number of the receiver
    /// @param _to the address to register
    function registerBlockTimeStamp(address _to) internal {
        IERC20AntiWhale(antiWhale).registerBlockTimeStamp(_to);
    }
    /// globally sets the exemptions
    /// @param _exemptions the addresses to set as exemptions
    function _setAntiWhaleExemptions(address[] memory _exemptions) internal {
        for (uint256 i = 0; i < _exemptions.length; i++) {
            antiWhaleExemptions[_exemptions[i]] = true;
        }
    }
    /// globally sets the exemptions
    /// @param _exemptions the addresses to set as exemptions
    function _setAntiWhaleSenderExemptions(address[] memory _exemptions) internal {
        for (uint256 i = 0; i < _exemptions.length; i++) {
            antiWhaleSenderExemptions[_exemptions[i]] = true;
        }
    }
}
