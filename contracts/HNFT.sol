// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "truffle/console.sol";

contract HNFT is ERC721 {
    uint public price;
    address issuer;

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) {
        issuer = msg.sender;
        _safeMint(msg.sender, 0);
    }

    function getIssuer() external view returns (address) {
        return issuer;
    }

    function getPrice() external view returns (uint) {
        return price;
    }

    function setPrice(uint _price) public returns (bool) {
        console.log("set price");

        require(
            _isApprovedOrOwner(tx.origin, 0),
            "The transaction origin caller is not allowed to perform this action"
        );
        require(
            _isApprovedOrOwner(msg.sender, 0),
            "The transaction origin caller is not allowed to perform this action"
        );
        price = _price;
        return true;
    }

    function transferBuy(address from, address to) public {
        require(
            _isApprovedOrOwner(msg.sender, 0),
            "The transaction origin caller is not allowed to perform this action"
        );
        super.transferFrom(from, to, 0);
    }

    function burn() public {
        console.log("burning token");
        _isApprovedOrOwner(tx.origin, 0);
        super._burn(0);
    }
}
