// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

contract variables_nativas {

    string private fullName; // solo puede acceder el que inicializo el contrato

    constructor(string memory _lastName) {
        fullName = string.concat("Mi nombre es:", " ", _lastName);
    }

    function getName() public view returns (string memory){
        return fullName;
    }

    /*
    uint enteros sin signo (no negativos)
    uint8 rango de 0 a 2 ** 8 -1
    uint16 rango de 0 a 2 ** 16 -1    
    */    

    uint8 public  uint_8 = 1;
    uint16 public uint_16 = 123; 

    // me permite guardar numeros con signo negativo
    int8 public int_8 = -1;

    // address como ta es una direccion
    address public my_address = 0xa92d504731aA3E99DF20ffd200ED03F9a55a6219;

}