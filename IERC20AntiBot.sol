// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;
/*
 * IERC20AntiBot interface
 */
/// @title ERC20AntiBot
/// @author Smithii

interface IERC20AntiBot {
    struct Options {
        bool applied;
        bool active;
    }
    /// errors
    error TokenNotActiveOnAntiBot();
    error TokenAlreadyActiveOnAntiBot();
    ///
    /// @param _from the address to check
    function isBotDetected(address _from) external returns (bool);
    /// Registers the block number of the receiver
    /// @param _to the address to register
    function registerBlock(address _to) external;
    /// Registers and pay for a token address to use the Antibot
    /// @param projectId the project id
    /// @param _tokenAddress the address to register
    function setCanUseAntiBot(
        bytes32 projectId,
        address _tokenAddress
    ) external payable;
    /// Set the exempt status of a trader
    /// @param _tokenAddress the token address
    /// @param _traderAddress the trader address
    /// @param _exempt the exempt status
    function setExempt(
        address _tokenAddress,
        address _traderAddress,
        bool _exempt
    ) external;
    /// helper function to check if the trader is exempt
    /// @param _tokenAddress the token address
    /// @param _traderAddress the trader address
    function isExempt(
        address _tokenAddress,
        address _traderAddress
    ) external returns (bool);
    ///
    /// @param _tokenAddress the token address
    /// @param _active the active oft he options to be applied
    function setActive(address _tokenAddress, bool _active) external;
    /// Check if the token address is active to use the Antibot
    /// @param _tokenAddress the address to check
    function isActive(address _tokenAddress) external returns (bool);
    /// Get if the token address can use the Antibot
    /// @param _tokenAddress the address to check
    function canUse(address _tokenAddress) external returns (bool);
}
