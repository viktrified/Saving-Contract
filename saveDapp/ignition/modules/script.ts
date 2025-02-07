import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const SavingModule = buildModule("SavingModule", (m) => {
  const Saving = m.contract("Saving");

  return { Saving };
});

export default SavingModule;
