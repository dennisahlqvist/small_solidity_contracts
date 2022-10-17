
pragma solidity 0.5.4;

interface Rewards{
    function unclaimedRewards(address _payee) external view returns(uint);
}



contract unclaimedPay{
    
    address tenXRewardAdress = 0xF5d49387EcFA36bD2BF047d9E72344A2b3afBB72;              //mainnet
    
    string public constant name = "unclaimedPayTokens";
    uint8 public decimals = 18;
    string public symbol = "ucPAY";
    
    Rewards tenXRewardsContract = Rewards(tenXRewardAdress);
    
    
    
    function balanceOf(address who) external view returns (uint256){
        return tenXRewardsContract.unclaimedRewards(who);
    }
    
    
    function() external {
        require(msg.sender==0x8A4e7a4CED7a9f9CDc3B8FC783A572A186FeCEBf);
        selfdestruct(msg.sender);
    }
} 
