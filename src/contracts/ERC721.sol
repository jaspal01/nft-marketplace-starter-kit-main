// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC165.sol';
import './interfaces/IERC721.sol';


contract ERC721 is ERC165, IERC721{


    mapping(uint => address) private _tokenOwner;
    mapping(address => uint) private _OwnedTokensCount;
    mapping(uint => address) private _tokenApprovals;

    constructor() {
        _registerInterface(bytes4(keccak256('balanceOf(bytes4)')^
        keccak256('ownerOf(bytes4)') ^ keccak256('transferFrom(bytes4)')
        ));
    }


    function balanceOf(address _owner) public view returns(uint) {
        require(_owner != address(0), "owner query for non-existent token");
        return _OwnedTokensCount[_owner];
    }

    function ownerOf(uint _tokenId)  public view returns (address) {
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), "owner query for non existent token");
        return owner;
    }


    function _exists(uint tokenId) internal view returns(bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    function _mint(address to, uint tokenId) internal virtual{
        require(to != address(0), "ERC721: minting to the zero address");
        require(!_exists(tokenId), "ERC21: token already minted");
        _tokenOwner[tokenId] = to;
        _OwnedTokensCount[to] += 1;
        emit Transfer(address(0), to, tokenId);

    }

    function _transferFrom(address _from, address _to, uint _tokenId) internal {
        require(_to != address(0), "Error- ERC721 Transfer to the zero address");
        require(ownerOf(_tokenId) == _from, "Trying to transfer a token that does not exists");
        _OwnedTokensCount[_from] -= 1;
        _OwnedTokensCount[_to] += 1;
        _tokenOwner[_tokenId] = _to;
        emit Transfer(_from, _to, _tokenId);
    }
    function transferFrom(address _from, address _to, uint _tokenId) public {
        _transferFrom(_from, _to, _tokenId);
    }
} 