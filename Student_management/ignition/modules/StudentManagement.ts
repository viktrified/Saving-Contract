import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const StudentManagementModule = buildModule("StudentManagementModule", (m) => {

    const studentManagement = m.contract("StudentManagement");

    return { studentManagement };
});

export default StudentManagementModule;