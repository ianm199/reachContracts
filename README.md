# reachContracts
What we're trying to build here is an open source collection of Reach contracts that allow developers to easily extend, iterate, and test them to faciliate a safer and more active development community. We're hoping this can be both an improvement in security and also 

### First contract - Vault contract
We wanted to start by creating an implementation of the vault pattern that become popular in the Algorand  ecosystem with protocols like AlgoFi and Folks Finance where users can lock up their Algo for governance and receive a wrapped token that allows them to be fully liquid during the governance period. It's likely in coming quarters other protocols will be fighting for market share in this area of Algorand Defi, so this seems like a good starting point.

The interface is relatively simple:
* Add funds: Users add Algo, receive a wrapped token like gAlgo equal to the amount added
* Users can vote on governance through the vault, sending a transaction to the Algorand governance system
* Users can redeem funds. If they do so before the end of the quarter, they invalidate their governance rewards
