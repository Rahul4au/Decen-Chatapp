//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract ChatApp {

    struct user{
        string name;
        friend[] friendList;
    }

    struct friend{
        address pubkey;
        string name;
    }

    struct message{
        address sender;
        uint256 timestamp;
        string msg;
    }

    struct allUserStruck{
        string name;
        address accountAddress;
    }

    allUserStruck[] getAllUsers;

    mapping(address => user) userList;
    mapping(bytes32=> message[]) allMessage;

    function checkUserExists(address pubkey) public view returns(bool){
        return bytes(userList[pubkey].name).length > 0;
    }

    function createAccount(string calldata name) external {
        require(checkUserExists(msg.sender) == false,"User already Exists");
        require(bytes(name).length>0,"Username cannot be empty");

        userList[msg.sender].name = name;
        getAllUsers.push(allUserStruck(name,msg.sender));
    }

    function getUsername(address pubkey) external view returns(string memory){
        require(checkUserExists(pubkey), "user is not Registered");
        return userList[pubkey].name;
    }

    function addFriends(address friend_key, string calldata name) external{
        require(checkUserExists(msg.sender), "Create an account first");
        require(checkUserExists(friend_key),"User not Registered!");
        require(msg.sender != friend_key, "User cannot add themselves as a friends");
        require(checkAlreadyFriends(msg.sender, friend_key) == false, "these users are already friends");

        _addFriend(msg.sender, friend_key, name);
        _addFriend(friend_key, msg.sender, userList[msg.sender].name);
    }

    function checkAlreadyFriends(address pubkey1, address pubkey2) internal view returns(bool){
        if (userList[pubkey1].friendList.length > userList[pubkey2].friendList.length) {
            address tmp = pubkey1;
            pubkey1 = pubkey2;
            pubkey2 = tmp;        
        }

        for(uint256 i = 0; i < userList[pubkey1].friendList.length; i++ ){
            if (userList[pubkey1].friendList[i].pubkey == pubkey2)
            return true;
        }
        return false;
    }


    function _addFriend(address me, address friend_key, string memory name) internal{
        friend memory newFriend = friend(friend_key, name);
        userList[me].friendList.push(newFriend);
    }

    function getMyFriendList() external view returns(friend[] memory){
        return userList[msg.sender].friendList;
    }

    function _getChatCode(address pubkey1, address pubkey2) internal pure returns(bytes32){
        if(pubkey1 < pubkey2){
            return keccak256(abi.encodePacked(pubkey1, pubkey2));
        } else return keccak256(abi.encodePacked(pubkey1, pubkey2));
    }

    function sendMessage(address friend_key,string calldata _msg) external {
        require(checkUserExists(msg.sender), "Create an account first");
        require(checkUserExists(friend_key), "User is Not REGISTER!!");
        require(checkAlreadyFriends(msg.sender,friend_key), "You are not the Friend with the given user");

        bytes32 chatCode = _getChatCode(msg.sender, friend_key);
        message memory newMsg = message(msg.sender,block.timestamp, _msg);
        allMessage[chatCode].push(newMsg);
    }

    function readMessage(address friend_key) external view returns(message[] memory){
        bytes32 chatCode = _getChatCode(msg.sender, friend_key);
        return allMessage[chatCode];
    }

    function getAllAppUsers() external view returns(allUserStruck[] memory){
        return getAllUsers;
    }
}


