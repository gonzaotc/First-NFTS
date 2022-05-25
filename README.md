## NFT's with mutable on-chain metadata.

In this project, the NFT's deployed on the polygon testnet can evolve and change their stats. <br/>

We can train the NFT's, executing a writing into the blockchain each time.
<br/>
They start as Warriors, at every level-up they increase their stats, and at level 5 they evolve into Templars. <br/>

### If you want, mint one, train him and see how he evolve ;)
https://mumbai.polygonscan.com/address/0x44C4eA6AefAbC0fB58046858635CB9e9b08232b7#writeContract
 
![image](https://user-images.githubusercontent.com/86085168/170384443-a97aebf8-c3f8-480b-b26c-4dc3904bd3dc.png) 

After executing train() method 4 times (4 levels up) <br/>
![image](https://user-images.githubusercontent.com/86085168/170384504-cc7d19b6-0dbf-42dc-a7c5-77dbffa803aa.png)

### Learning takeaways
- I learned how to save my NFT metadata in the blockchain and the differences with having it off-chain, in services like IPFS.
- I learned do fuctions that are able to manipulate the on-chain metadata, bringing infinite possibilities.
- I learned a lot more about type conversiones and encoding, base64 strings, abi.encode(), abi.encodePack(), and using OpenZepellin utils as Strings, Counters.




