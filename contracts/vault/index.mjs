import { loadStdlib } from '@reach-sh/stdlib';
import * as backend from './build/index.main.mjs';

const stdlib = await loadStdlib();
const startingBalance = stdlib.parseCurrency(100); // micro algos

console.log("creating deployer contract");
const deployerMcgee = await stdlib.newTestAccount(startingBalance);

console.log("Creating api interactor");
const governor = await stdlib.newTestAccount(startingBalance);

const ctcDeployer = deployerMcgee.contract(backend);

await ctcDeployer.participants.Creator({
    vaultReady: () => {
        console.log("Ready to add to governance")
    }
});

const ctcGov = governor.contract(backend, ctcDeployer.getInfo());
const getBal = async () => stdlib.formatCurrency(await stdlib.balanceOf(acc));
console.log(`Balance before ${getBal(ctcGov)}`);
const addedFunds = await ctcGov.apis.addFunds(stdlib.parseCurrency(50));
console.log(`Balance after ${getBal(ctcGov)}`);