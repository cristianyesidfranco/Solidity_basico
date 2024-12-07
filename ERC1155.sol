// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenManager is ERC1155Supply, Ownable {
    // Mapas para gestionar las listas blanca y negra
    mapping(address => bool) public whitelist;
    mapping(address => bool) public blacklist;

    // Constructor: Llama explícitamente a los constructores de ERC1155 y Ownable
    constructor(address initialOwner) ERC1155("https://api.example.com/metadata/{id}.json") Ownable(initialOwner) {
        transferOwnership(initialOwner);  // Transfiere la propiedad al dueño proporcionado
    }

    // Modificador: Verifica si el remitente está en la lista blanca
    modifier onlyWhitelisted() {
        require(whitelist[msg.sender], "No estA en la lista blanca");
        _;
    }

    // Modificador: Verifica si el remitente no está en la lista negra
    modifier onlyNotBlacklisted() {
        require(!blacklist[msg.sender], "La direccion esta en la lista negra");
        _;
    }

    // Agrega una dirección a la lista blanca
    function addToWhitelist(address account) external onlyOwner {
        whitelist[account] = true;
    }

    // Elimina una dirección de la lista blanca
    function removeFromWhitelist(address account) external onlyOwner {
        whitelist[account] = false;
    }

    // Agrega una dirección a la lista negra
    function addToBlacklist(address account) external onlyOwner {
        blacklist[account] = true;
    }

    // Elimina una dirección de la lista negra
    function removeFromBlacklist(address account) external onlyOwner {
        blacklist[account] = false;
    }

    // Función de acuñación: Solo los usuarios en la lista blanca y no en la lista negra pueden acuñar tokens
    function mint(uint256 id, uint256 amount) external onlyWhitelisted onlyNotBlacklisted {
        _mint(msg.sender, id, amount, "");
    }

    // Sobrescribe la función safeTransfer para evitar transferencias a direcciones en la lista negra
    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public override onlyNotBlacklisted {
        require(whitelist[to], "El destinatario no esta en la lista blanca");
        super.safeTransferFrom(from, to, id, amount, data);
    }
}
