// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./ERC721.sol";
import "./interfaces/IERC721Enumerable.sol";

contract ERC721Enumerable is IERC721Enumerable, ERC721{
    uint[] private _allTokens;

    mapping(uint => uint) private _allTokensIndex;
    mapping(address => uint[]) private _ownedTokens;
    mapping(uint => uint) private _ownedTokensIndex;


    constructor() {
        _registerInterface(bytes4(keccak256('totalSupply(bytes4)')^
        keccak256('tokenByIndex(bytes4)') ^ keccak256('tokenOdOwnerByIndex(bytes4)')
        ));
    }


    function _mint(address to, uint tokenId) internal override(ERC721) {
        super._mint(to, tokenId);
        _addTokensToAllTokenEnumeration(tokenId);
        _addTokensToOwnerEnumeration(to, tokenId);
    }
    function _addTokensToAllTokenEnumeration(uint tokenId) private {
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    function _addTokensToOwnerEnumeration(address to, uint tokenId) private {
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
    }

    function tokenByIndex(uint index) public view returns(uint) {
        require(index < totalSupply(), "global index is out of bounds");
        return _allTokens[index];
    }

    function tokenOfOwnerByIndex(address owner, uint index) public view returns (uint) {
        require(index < balanceOf(owner), "owner index is out of bounds");
        return _ownedTokens[owner][index];
    }

    function totalSupply() public view returns(uint) {
        return _allTokens.length;
    }
}