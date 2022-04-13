'reach 0.1'

export const main = Reach.App(() => {
   const Creator = Participant('Creator', {
       vaultReady: Fun([], Null)
   });
   const Governor = API('Governor', {
       addFunds: Fun([UInt], Bool),
       removeFunds: Fun([UInt], Null),
       govern: Fun([UInt], Null)
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
   const gov = parallelReduce([true]).invariant(true).while(lastConsensusTime() <= end)
       .api(Governor.addFunds,
           ((addFunds) => {
               assume(addFunds <= 1000000000);
           }),
           (addFunds) => addFunds,
           () => {
               return true
           }).timeout(absoluteTime(end), () => {
               Creator.publish();
               return true
    }); // what we could check here is that the user is not adding too much funds
    commit();
    exit();
});