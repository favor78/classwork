pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import "@openzeppelin/token/ERC721/ERC721.sol";
import "solidity-bytes-utils/contracts/BytesLib.sol";
import "./IRealXToken.sol";

contract RealXMarketPlace is ERC721 {

    address minterAddress;


    struct ownershiprightsInfo{
        string fullName;
        string gender;
        string nationality;
        string nationalIDnumber
        }

     struct PropertyInfo{
     uint256 propertyTitleIDnumber;
     uint256 surveyPlanNumber;
     string latitudeCordinate;
     string longitudeCordinate;     
     string propertyDescription;
     uint256 propertyPrice;
     string imageHash;
     ownershiprightsInfo ownershiprightsInfo;
    }

    PropertyInfo[] public list_of_minted_properties;

    mapping(uint256 => bool) _propertyExist;
    mapping(uint256 => PropertyInfo) public _propertyInfoList;

    event PropertyMinted(
        uint256 propertyTitleIDnumber,
        string surveyPlanNumber,
        string latitudeCordinates, 
        string longitudeCordinates,
        string minterName,  
        address indexed mintedAddr,
        uint256 mintedTime);



    constructor(address realXtoken_address) ERC721("InveX Token", "IVX") public {
        IRealXToken realXToken = IRealXToken(realXtoken_address);
    }


        function mintRealXProperty(
            string memory _propertyOwnerName, 
            string memory _gender, 
            string memory _nationality,
            string memory _nationalIDnumber
            uint256 memory _propertyTitleIDnumber,
            string memory _surveyPlanNumber,
            string memory _latitudeCordinates,
            string memory _longitudeCordinates
            string memory _propertyDescription,
            uint256 memory _propertyPrice,
            string memory _propertyHash) public {

            uint256 _chainId;

                assembly {
                 _chainId := chainid()
                }
            
            uint _id = PropertyInfo.push(mint_property);
            
            bytes32 TOKENID = keccak256(abi.encodePacked(_chainId, PropertyInfo ));

            uint256 _tokenId =  toUint256(TOKENID, 0);

            require(_propertyInfoList[_tokenId].propertyTltleIDnumber != _propertyTitleIDnumber);
            require(_propertyInfoList[_tokenId].surveyPlanNumber != -surveyPlanNumber);
            require(_propertyInfoList[_tokenId].latitudeCordinates != _latitudeCordinates);
            require(_propertyInfoList[_tokenId].longitudeCordinates != _longitudeCordinates);              
            require(_propertyInfoList[_tokenId].property_Description != _property_Description);
            require(realXToken.balanceOf[msg.sender] > 0)

            _mint(msg.sender, _tokenId);

            _propertyExist[_tokenId] = true;
            _propertyInfoList[_tokenId].propertyTitleIDnumber = _proptertyTitleIDnumber;
            _propertyInfoList[_tokenId].surveyPlanNumber= _surveyPlanNumber
            _propertyInfoList[_tokenId].LatitudeCordinates = _latitudeCordinates;
            _propertyInfoList[_tokenId].longitudeCordinates = _longitudeCordinates;          
            _propertyInfoList[_tokenId].propertyDescription = _propertyDescription;
            _propertyInfoList[_tokenId].propertyPrice = _propertyPrice;
            _propertyInfoList[_tokenId].imageHash = _propertyHash;
            _propertyInfoList[_tokenId].ownershiprightsInfo.fullName = _propertyOwnerName;
            _propertyInfoList[_tokenId].ownershiprightsInfo.gender = _gender[male,female];
            _propertyInfoList[_tokenId].ownershiprightsInfo.nationality = _nationality;
            _propertyInfoList[_tokenId].ownershiprightsInfo.nationalIDnumber = _nationalIDnumber; 


            emit PropertyIDnumberMinted(_propertyTitleIDnumber,surveyPlanNumber, _latitudeCordinates, _longitudeCordinates, msg.sender, block.timestamp);

        }

}
