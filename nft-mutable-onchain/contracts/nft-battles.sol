pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract NftBattles is ERC721URIStorage{
    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct Stats{
        string class;
        uint16 level;
        uint16 strenght;
        uint16 health;
        uint16 defense;
    }

    mapping(uint256 => Stats) public tokenIdToStats;

    constructor() ERC721("nft-battles","NFTB" ){
    }

        function generateCharacter(uint256 tokenId) public returns (string memory){

            // takes string arguments, concatenates them  and returns bytes.
            // the "packed" version uses the smallest ammount of bytes possible, to save some gas. 
            bytes memory svg = abi.encodePacked(
                '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">',
                '<style>.base { fill: white; font-family: serif; font-size: 14px; }</style>',
                '<rect width="100%" height="100%" fill="black" />',
                '<text x="50%" y="40%" class="base" dominant-baseline="middle" text-anchor="middle">', getStats(tokenId).class, '</text>',
                '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">', "Levels: ", Strings.toString(getStats(tokenId).level), '</text>',
                '<text x="50%" y="60%" class="base" dominant-baseline="middle" text-anchor="middle">', "Health: ", Strings.toString(getStats(tokenId).health), '</text>',
                '<text x="50%" y="70%" class="base" dominant-baseline="middle" text-anchor="middle">', "Strenght: ", Strings.toString(getStats(tokenId).strenght), '</text>',
                '<text x="50%" y="80%" class="base" dominant-baseline="middle" text-anchor="middle">', "Defense: ", Strings.toString(getStats(tokenId).defense), '</text>',
                '</svg>'
            );


            return string(
                // we to this to concatenate "data:image/svg+xml;base64 (explicity string) with the encoded svg. (base64 string)
                abi.encodePacked(
                    "data:image/svg+xml;base64,",
                    // Base64 encode takes bytes (the encodePacked svg) and returns a base64 string. 
                    Base64.encode(svg)
                )
            );
        }

    // must be returned as a string, because the abi.enodePacked arguments always must resolve to strings.
    function getStats(uint256 tokenId) public view returns (Stats memory){
        Stats memory stats = tokenIdToStats[tokenId];
        return stats;
    }


    function getTokenURI(uint256 tokenId) public returns (string memory){
        bytes memory dataURI = abi.encodePacked(
            '{',
                '"name": "NFT Battles #', tokenId.toString(), '",',
                '"description": "NFT battles",',
                '"image": "', generateCharacter(tokenId), '"',
            '}'
        );
        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(dataURI)
            )
        );
    }

    function mint() public {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _safeMint(msg.sender, newItemId);
        tokenIdToStats[newItemId].class = "Warrior";
        tokenIdToStats[newItemId].level= 1;
        tokenIdToStats[newItemId].strenght= 1;
        tokenIdToStats[newItemId].health= 50;
        tokenIdToStats[newItemId].defense= 1;
        _setTokenURI(newItemId, getTokenURI(newItemId));
    }

    function train(uint256 tokenId) public {
        require(_exists(tokenId), "Please use an existing Token");
        require(ownerOf(tokenId) == msg.sender, "You must own this token to train it");

        tokenIdToStats[tokenId].level+= 1;
        tokenIdToStats[tokenId].strenght+= 2;
        tokenIdToStats[tokenId].health+= 50;
        tokenIdToStats[tokenId].defense+= 3;

        if (tokenIdToStats[tokenId].level > 5){
            tokenIdToStats[tokenId].class = "Templar";
        }

        _setTokenURI(tokenId, getTokenURI(tokenId));
    }
}