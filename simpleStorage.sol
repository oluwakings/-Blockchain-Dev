// SPDX-License-Identifier: MIT
pragma solidity 0.8.19; // this is the solididty version

contract SimpleStorage {
    // note that when using uint, the the value is initialised to 0 if no value is given. below uint is for favoritenumber and it is initialised to 0

     uint256  myFavoriteNumber; // 0
     // when there is no visibility keyweyword it is default to internal . other keywords include public private and external
     // uint256[] list of other favorite numbers for an array
     struct Person {
        uint256 favoriteNumber;
        string name;
     }
     Person [] public listOfPeople;

     mapping(string => uint256) public nameToFavoriteNumber; //any value not added defaults to zero in mapping

     // person public kings = person({favoriteNumber: 7, name: "kings"});
     // person public mama = person({favoriteNumber: 10, name: "mama"});
     // person public opez = person({favoriteNumber: 8, name: "opez"});
     // person public isah = person({favoriteNumber: 90, name: "isah"});

     function store(uint256 _favoriteNumber) public virtual  {
        myFavoriteNumber = _favoriteNumber;
        // view, pure are functions that do not cost gas because there can be deployed without changing anything in the blockchain
     }
     
     function retrieve () public view returns(uint256){
        return myFavoriteNumber;
     }

     function addPerson(string memory _name, uint256 _favoriteNumber) public  {
        listOfPeople.push( Person(_favoriteNumber, _name) );
        nameToFavoriteNumber[_name] = _favoriteNumber;
     }

}
