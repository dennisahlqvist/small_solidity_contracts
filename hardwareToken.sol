contract HardwareToken {
  address public owner;
  address public signer; //hardwarewallet
  bool[] public transactionSigned;
  address[] public transactionReciver;
  uint[] public transactionAmount;

  tokenInterface token = tokenInterface(0x5B8026BBD5954e060cF152206Ae226782fB74FA5); // test token
  modifier onlyOwner() {if ( msg.sender != owner ) throw; _}
  modifier onlySigner() {if ( msg.sender != owner ) throw; _}
  function HardwareToken() {
    owner = msg.sender; // act 1 testnet
    signer = 0x7a1EF2b59246bCb69931314332FfDd75659B4943; // acc 2 testnet

    for( uint i=0 ; i<=1 ; i++ ){
        transactionReciver.push(0x0000000000000000000000000000000000000000);
        transactionAmount.push(0);
        transactionSigned.push(false);
    }
  }

  function() {
    if (signer != msg.sender){throw;}


    if (msg.value==1){ ///0.000000000000000001 / 1 wei
      // sets signer address
      //if(0x0000000000000000000000000000000000000000 == signer) {
        //signer = msg.sender;
      //}

      /*}else if(msg.value==2){ ///0.000000000000000002 / 2 wei
        // confirm that signer address does not change*/
      }else{
        if((transactionReciver[msg.value] != 0x0000000000000000000000000000000000000000 &&
            transactionAmount[msg.value] != 0) &&
            transactionSigned[msg.value] == false
          ){

          transactionSigned[msg.value] = true;
          if(!token.transfer(transactionReciver[msg.value], transactionAmount[msg.value])){throw;}

          }

          msg.sender.send(msg.value);                          // Send back ether sent
    }
  }


  function transfer(address _to, uint256 _value) onlyOwner returns (bool success){
    transactionReciver.push(_to);
    transactionAmount.push(_value);
    transactionSigned.push(false);

    return true; //todo fixme!
  }


  function totalSupply() constant returns (uint256 supply){
    return token.totalSupply();
  }

  function balanceOf(address _owner) constant returns (uint256 balance){
    return token.balanceOf(this);
  }


  function uintInArray(uint inUint, uint[] _uintArray) private returns (bool inArray){
    for(uint256 i=0; i<_uintArray.length;i++){
      if(_uintArray[i]==inUint){
        return true;
      }
    }
    return false;
  }
  function kill() onlyOwner {
    suicide(owner);
  }

  function claimEtherOwner(uint amount) onlyOwner {
    if(!owner.send(amount)){throw;}
  }

  function claimEtherSigner(uint amount) onlyOwner {
    if(!signer.send(amount)){throw;}
  }

  function addGasEther() returns (bool success){
    return true;
  }

}
contract tokenInterface {
    function totalSupply() constant returns (uint256 supply);
    function balanceOf(address _owner) constant returns (uint256 balance);
    function transfer(address _to, uint256 _value) returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success);
    function approve(address _spender, uint256 _value) returns (bool success);
    function allowance(address _owner, address _spender) constant returns (uint256 remaining);

}
