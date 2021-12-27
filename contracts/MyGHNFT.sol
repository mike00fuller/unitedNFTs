  // SPDX-License-Identifier: UNLICENSED

  pragma solidity ^0.8.0;

  import "hardhat/console.sol";
  import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
  import "@openzeppelin/contracts/utils/Counters.sol";
  import { Base64 } from "./libraries/Base64.sol";

  contract MyGHNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

     event NewGHNFTminted(address sender, uint256 tokenId);

     string flag = " <svg xmlns=\"http://www.w3.org/2000/svg\" id=\"flag-icons-gh\" viewBox=\"0 0 640 480\"> <path fill=\"#006b3f\" d=\"M0 0h640v480H0z\"/><path fill=\"#fcd116\" d=\"M0 0h640v320H0z\"/>  <path fill=\"#ce1126\" d=\"M0 0h640v160H0z\"/>  <path d=\"m320 160 52 160-136.1-98.9H404L268 320z\"/>  </svg> ";


    constructor() ERC721 ("GHANA", "GHC") {
        console.log("This is my GHC NFT contract.");
      }




     function forgeGHNFT() public {
      uint256 newItemId = _tokenIds.current();

          string memory finalflag = string(abi.encodePacked(flag));
         string memory json = Base64.encode(
                bytes(
                    string(
                        abi.encodePacked(
                            '{"name": "GHANA", "description": "The United Three Lions.", "image": "data:image/svg+xml;base64,',
                            // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                            Base64.encode(bytes(finalflag)),
                            '"}'
                    ) ) ) );
  string memory finalTokenUri = string(
        abi.encodePacked("data:application/json;base64,", json)
    );
         console.log("\n--------------------");
        console.log(
             string(
                 abi.encodePacked(
                     "https://nftpreview.0xdev.codes/?code=",
                     finalTokenUri
                 ) ) );
         console.log("--------------------\n");
      _safeMint(msg.sender, newItemId);
      _setTokenURI(newItemId, finalTokenUri);
      console.log("An NFT with ID %s has been minted to %s", newItemId, msg.sender);
      _tokenIds.increment();
      emit NewGHNFTminted(msg.sender, newItemId);

      }

  }
