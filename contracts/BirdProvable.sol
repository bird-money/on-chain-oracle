pragma solidity >= 0.5.0 < 0.6.0;

import "github.com/oraclize/ethereum-api/provableAPI.sol";

contract BirdRating is usingProvable {

    string public userBirdRating;

    event LogNewUserRating(string rating);
    event LogNewProvableQuery(string description);


    constructor(string memory _str_address)
        public
    {
        update(_str_address); // First check at contract creation...
    }

    function __callback(
        bytes32 myid,
        string memory result
    )
        public
    {
        require(msg.sender == provable_cbAddress());
        emit LogNewUserRating(result);
        userBirdRating = result; // Let's save it as cents...
        // Now do something with the USD Diesel price...
    }
    
    
    function append(string memory a, string memory b) internal pure returns (string memory) {

    return string(abi.encodePacked(a, b));

    }


    function update(string memory _userAddress)
        public
        payable
    {
        // string _url = append('https://www.bird.money/analytics/','');
        string memory _url = string(abi.encodePacked("json(https://www.bird.money/analytics/address/", _userAddress,").bird_rating"));
        
        emit LogNewProvableQuery("Provable query was sent, standing by for the answer...");
        provable_query("URL", _url);

    }
}