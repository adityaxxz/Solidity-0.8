// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

interface IERC165 {
    function supportsInterface(bytes4 interfaceID) external view returns (bool) ;
}

interface IERC721 is IERC165 {
    function balanceOf(address owner) external view returns (uint balance);

    function ownerOf(uint tokenId) external view returns (address owner);

    function safeTransferFrom(address from, address to, uint tokenId) external;

    function safeTransferFrom(address from,address to,uint tokenId,bytes calldata data) external;

    function transferFrom(address from, address to, uint tokenId) external;

    function approve(address to, uint tokenId) external;

    function getApproved(uint tokenId) external view returns (address operator);

    function setApprovalForAll(address operator, bool _approved) external;

    function isApprovedForAll(address owner,address operator) external view returns (bool);
}


interface IERC721Receiver {
    function onERC721Receieved (address operator,address from,uint tokenId,bytes calldata data) external returns (bytes4);
}