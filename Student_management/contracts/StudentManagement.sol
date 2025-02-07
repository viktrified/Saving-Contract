// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract StudentManagement {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the admin");
        _;
    }

    enum Gender{ Male, Female }

    mapping (uint256 => string) name;
    mapping(uint8 => Student) public students;

    // Events
    event CreatedStudent(
        string indexed  name,
        string indexed class,
        uint8 indexed age
    );

    error CouldNotGetStudent();

    

    struct Student {
        string name;
        uint8 age;
        string class;
        Gender gender;
    }

    uint8 public studentId = 0;
    // Student[] allStudents;
    

    function registerStudent(
        string memory _name,
        uint8 _age,
        string memory _class,
        Gender _gender
    ) external onlyOwner {

        Student memory student = Student({
            name: _name,
            age: _age,
            class: _class,
            gender: _gender
        });

        
        studentId++;
        students[studentId] = student;

    
        // emit CreatedStudent(_name, _class, _age);
    }



    function getStudent(uint8 _studentId) public view  returns (Student memory student_) {
        if (_studentId > studentId) {
            revert CouldNotGetStudent();
        }
        student_ = students[_studentId];
    }

    function getStudents() public view  returns (Student[] memory students_) {
        students_ = new Student[](studentId);

       for (uint8 i = 1; i <= studentId; i++) {
        students_[i - 1] = students[i];
       }

       students_;
    }
   
}
