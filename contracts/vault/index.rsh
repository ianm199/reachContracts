'reach 0.1'

export const main = Reach.App(() => {
   const Creator = Participant('Creator', {
       vaultReady: Fun([], Null)
   });
   const Governor = API('Governor', {
       addFunds: Fun([UInt], Bool),
       // removeFunds: Fun([UInt], Null),
       // govern: Fun([UInt], Null)
   });
   init();
   Creator.only(() => {
       const test = "test";
   });
   Creator.publish(test);
   commit();
   Creator.pay(1);
   Creator.interact.vaultReady();

   const end = lastConsensusTime() + 20000000;
   // this is kinda where were confused JP pls
   const gov = parallelReduce(true)
       .invariant(true)
       .while(lastConsensusTime() <= end) // There some keyword like keepGoing()?
       .api(Governor.addFunds, // API EXPR - the API method were defining
           ((addFunds) => {
               assume(addFunds <= 1000000000); // Could check balance of AP usere here
           }),
           (addFunds) => addFunds, // Send the funds to the contract... Maybe in the future this would be part of a mapping
           (addFunds, notify) => {
           notify(true);
               return true
           }) // Here I think we would actually want to send them a token... But one thing at a time
       .timeout(absoluteTime(end), () => {
               Creator.publish();
               return true
    }); // what we could check here is that the user is not adding too much funds
    commit();
    // In RSVP app we check the leftovers and transfer the funds back to the admin
    Creator.publish();
    const bal = balance()
    transfer(bal).to(Creator);
    commit();
    exit();
});