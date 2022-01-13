// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-solidity/contracts/token/ERC721/ERC721.sol";


contract verify{
    address sk = 0xd9145CCE52D386f254917e481eB44e9943F39138;
    mapping (address => bool) private Wallets;
    function collect() public payable{}

    function hasScarletKnight(address user) private view returns(bool){
        ERC721 instance = ERC721(sk);
        return instance.balanceOf(user) > 0;
    }

    function collectReward() public 
    {
        require(hasScarletKnight(msg.sender));
        require( !hasClaimed(msg.sender) );

        setWallet(msg.sender);
        payable(msg.sender).transfer(1 ether);

    }

    function setWallet(address _wallet) private {
        Wallets[_wallet]=true;
    }

    function hasClaimed(address _wallet) private view returns (bool){
        return Wallets[_wallet];
    }
    
    function getBalance() public view returns (uint256){
        return address(this).balance;
    }

}
