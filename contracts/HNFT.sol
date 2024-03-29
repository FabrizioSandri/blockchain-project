// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

//add for debugging purpuse
//import "truffle/console.sol";

contract HNFT is ERC721URIStorage {
    uint256 private price;
    address private issuer;
    
    modifier ownerOrApproved() {
        require(
            _isApprovedOrOwner(msg.sender, 0),
            "The transaction caller is not allowed to perform this action"
        );
        _;
    }

    constructor(
        string memory _name,
        string memory _symbol,
        string memory tokenURI
    ) ERC721(_name, _symbol) {
        issuer = msg.sender;
        _safeMint(msg.sender, 0);
        _setTokenURI(0, tokenURI);
    }

    function getIssuer() external view returns (address) {
        return issuer;
    }

    function getPrice() external view returns (uint256) {
        return price;
    }

    function setPrice(uint256 _price) external ownerOrApproved returns (bool) {
        price = _price;
        return true;
    }

    function transferBuy(address from, address to) external ownerOrApproved {
        super.transferFrom(from, to, 0);
    }

    function burn(address mainSmartContractAddress) external ownerOrApproved {
        (bool resb, ) = mainSmartContractAddress.call(
            abi.encodeWithSignature("getRealHoney()")
        );
        if (resb) {
            super._burn(0);
        } else {
            revert("error in main smart contract burn");
        }
    }
}
