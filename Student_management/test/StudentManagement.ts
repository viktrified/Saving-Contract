import {
  time,
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import hre from "hardhat";

describe("StudentManagement", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployStudentManagement() {
    // Contracts are deployed using the first signer/account by default
    const [owner, account1, account2, account3] = await hre.ethers.getSigners();

    const studentManagement = await hre.ethers.getContractFactory(
      "StudentManagement"
    );

    const studentManagementContract = await studentManagement.deploy();

    return { studentManagementContract, owner, account1, account2, account3 };
  }

  describe("Deployment", function () {
    it("Should set the right unlockTime", async function () {
      const { studentManagementContract, owner, account1, account2, account3 } =
        await loadFixture(deployStudentManagement);

      expect(await studentManagementContract.owner()).to.not.eq(account1);

      expect(await studentManagementContract.owner()).to.eq(owner);
    });

    it("Should test for register student", async function () {
      const { studentManagementContract, owner, account1, account2, account3 } =
        await loadFixture(deployStudentManagement);

      const name = "john doe";
      const age = 12;
      const studentClass = "js1";
      const gender = 0;

      const studentId = await studentManagementContract.studentId();
      expect(
        await studentManagementContract.registerStudent(
          name,
          age,
          studentClass,
          gender
        )
      )
        .to.emit(studentManagementContract, "CreatedStudent")
        .withArgs(name, 12, studentClass);
    });

    it("Should test for register student", async function () {
      const { studentManagementContract, owner, account1, account2, account3 } =
        await loadFixture(deployStudentManagement);

      const name = "john doe";
      const age = 12;
      const studentClass = "js1";
      const gender = 0;

      await studentManagementContract.registerStudent(
        name,
        age,
        studentClass,
        gender
      );

      const student = await studentManagementContract.getStudent(1);
      expect(await student.name).to.eq("john doe");
    });

    it("Should give custom error when getting a student that does not exist", async function () {
      const { studentManagementContract, owner, account1, account2, account3 } =
        await loadFixture(deployStudentManagement);

      const name = "john doe";
      const age = 12;
      const studentClass = "js1";
      const gender = 0;

      await studentManagementContract.registerStudent(
        name,
        age,
        studentClass,
        gender
      );

      await expect(
        studentManagementContract.getStudent(5)
      ).to.be.revertedWithCustomError(
        studentManagementContract,
        "CouldNotGetStudent()"
      );
    });

    it("Should fails when registering student with non admin account", async function () {
      const { studentManagementContract, owner, account1, account2, account3 } =
        await loadFixture(deployStudentManagement);

      const name = "john doe";
      const age = 12;
      const studentClass = "js1";
      const gender = 0;

      await expect(
        studentManagementContract
          .connect(account1)
          .registerStudent(name, age, studentClass, gender)
      ).to.be.revertedWith("You are not the admin");
    });

    it("Should check that getStudents() gets all registered student", async function () {
      const { studentManagementContract, owner, account1, account2 } =
        await loadFixture(deployStudentManagement);

      const name = "john doe";
      const age = 12;
      const studentClass = "js1";
      const gender = 0;

      const name2 = "Jane Doe";
      const age2 = 14;
      const studentClass2 = "js2";
      const gender2 = 1;

      await studentManagementContract.registerStudent(
        name,
        age,
        studentClass,
        gender
      );
      await studentManagementContract.registerStudent(
        name2,
        age2,
        studentClass2,
        gender2
      );

      const students = await studentManagementContract.getStudents();

      expect(students.length).to.equal(2);
      expect(students[0].name).to.equal(name);
      expect(students[1].name).to.equal(name2);
    });
  });
});
