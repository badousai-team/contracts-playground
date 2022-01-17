// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

contract OneGogh is Context, ERC1155, ERC1155Holder {
    using Counters for Counters.Counter;
    using EnumerableSet for EnumerableSet.UintSet;

    Counters.Counter public _tokenIdTracker;

    mapping(uint256 => address) public creator;
    mapping(address => EnumerableSet.UintSet) private _minterTokens;

    constructor() ERC1155("https://onegogh.majin.land/web3/{id}.json") {

    }

    function mint() public payable returns (uint) {
        uint mintedToken = _tokenIdTracker.current();
        _minterTokens[msg.sender].add(mintedToken);
        _mint(msg.sender, mintedToken, 1, "");
        creator[mintedToken] = msg.sender;
        _tokenIdTracker.increment();

        return mintedToken;
    }

    function tokensByOwner(address _owner) external view returns (uint256[] memory) {
        uint256 tokenCount = _minterTokens[_owner].length();
        if (tokenCount == 0) {
            // Return an empty array
            return new uint256[](0);
        } else {
            uint256[] memory result = new uint256[](tokenCount);
            uint256 index;
            for (index = 0; index < tokenCount; index++) {
                result[index] = _minterTokens[_owner].at(index);
            }
            return result;
        }
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC1155, ERC1155Receiver) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}