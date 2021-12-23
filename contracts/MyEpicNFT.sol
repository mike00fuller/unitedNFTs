  // SPDX-License-Identifier: UNLICENSED

  pragma solidity ^0.8.0;

  import "hardhat/console.sol";
  import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
  import "@openzeppelin/contracts/utils/Counters.sol";
  import { Base64 } from "./libraries/Base64.sol";

  contract EpicTrioNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
     string[] firstWords = ["RONALDO", "RASHFORD", "SANCHO", "GREENWOOD", "MARTIAL", "CAVANI"];
     string[] secondWords = ["FERNANDES", "POGBA", "MCTOMINAY", "FRED", "MATA", "LINGARD"];
     string[] thirdWords = ["BAILLY", "VARANE", "LINDELOF", "WAN-BISSAKA", "TELLES", "SHAW"];

     string fw = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 180 170'> <style>.base { fill: white; font-family: copperplate; font-size: 15px; } .main { fill: white; font-family: copperplate; font-size: 20px;} .num { fill:white; font-family: serif; font-size: 15px; font-weight: bold; } .mainnum { fill:white; font-family: serif; font-size: 20px; font-weight: bold; </style> <rect width='100%' height='100%' rx='20' ry='20' fill='red' style= 'stroke:black; stroke-width:25; opacity:1' /> <text x='50%' y='25%' class='base' dominant-baseline='middle' text-anchor='middle'>";
     string sw = "</text> <text x='50%' y='50%' class='main' dominant-baseline='middle' text-anchor='middle'>";
     string tw = " </text> <text x='50%' y='75%' class='base' dominant-baseline='middle' text-anchor='middle'> ";
     string ew = "</text> </svg>";


    constructor() ERC721 ("UNITEDNFT", "UNFT") {
        console.log("This is my NFT contract. Whoa!");
      }

    function pickRandomFirstWord(uint256 tokenId) public view returns (string memory) {

        uint256 rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));
        // Squash the # between 0 and the length of the array to avoid going out of bounds.
        rand = rand % firstWords.length;
        return firstWords[rand];
      }
      function pickRandomSecondWord(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId))));
    rand = rand % secondWords.length;
    return secondWords[rand];
      }
      function pickRandomThirdWord(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId))));
    rand = rand % thirdWords.length;
    return thirdWords[rand];
      }
      function random(string memory input) internal pure returns (uint256) {
      return uint256(keccak256(abi.encodePacked(input)));
      }




     function BuildAnEpicTrio() public {
      uint256 newItemId = _tokenIds.current();

         string memory first = pickRandomFirstWord(newItemId);
         string memory second = pickRandomSecondWord(newItemId);
         string memory third = pickRandomThirdWord(newItemId);


         string memory finalSvg = string(abi.encodePacked(fw, first, sw, second, tw, third, ew));

         string memory json = Base64.encode(
                bytes(
                    string(
                        abi.encodePacked(
                            '{"name": "',
                            // We set the title of our NFT as the generated word.
                            first,
                            '", "description": "The United Three Lions.", "image": "data:image/svg+xml;base64,',
                            // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                            Base64.encode(bytes(finalSvg)),
                            '"}'
                        )
                    )
                )
            );

  string memory finalTokenUri = string(
        abi.encodePacked("data:application/json;base64,", json)
    );

         console.log("\n--------------------");
        console.log(
             string(
                 abi.encodePacked(
                     "https://nftpreview.0xdev.codes/?code=",
                     finalTokenUri
                 )
             )
          );
         console.log("--------------------\n");


      _safeMint(msg.sender, newItemId);
      _setTokenURI(newItemId, finalTokenUri);
      console.log("An NFT with ID %s has been minted to %s", newItemId, msg.sender);
      _tokenIds.increment();
      }
  }
