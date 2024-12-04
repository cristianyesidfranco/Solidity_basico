// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract ERC3643WhitelistBlacklist {
    // Eventos
    event AddedToWhitelist(address indexed account);
    event RemovedFromWhitelist(address indexed account);
    event AddedToBlacklist(address indexed account);
    event RemovedFromBlacklist(address indexed account);

    // Roles administrativos
    address public admin;

    // Mapas para listas blanca y negra
    mapping(address => bool) private whitelist;
    mapping(address => bool) private blacklist;

    constructor() {
        admin = msg.sender; // Asignar el despliegue al administrador inicial
    }

    // Modificador para funciones solo del administrador
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    // Modificador para verificar si está en la lista negra
    modifier notBlacklisted(address account) {
        require(!blacklist[account], "Address is blacklisted");
        _;
    }

    // Funciones para la lista blanca
    function addToWhitelist(address account) external onlyAdmin {
        require(!whitelist[account], "Address already in whitelist");
        require(!blacklist[account], "Address is in blacklist");
        whitelist[account] = true;
        emit AddedToWhitelist(account);
    }

    function removeFromWhitelist(address account) external onlyAdmin {
        require(whitelist[account], "Address not in whitelist");
        whitelist[account] = false;
        emit RemovedFromWhitelist(account);
    }

    function isWhitelisted(address account) public view returns (bool) {
        return whitelist[account];
    }

    // Funciones para la lista negra
    function addToBlacklist(address account) external onlyAdmin {
        require(!blacklist[account], "Address already in blacklist");
        require(!whitelist[account], "Address is in whitelist");
        blacklist[account] = true;
        emit AddedToBlacklist(account);
    }

    function removeFromBlacklist(address account) external onlyAdmin {
        require(blacklist[account], "Address not in blacklist");
        blacklist[account] = false;
        emit RemovedFromBlacklist(account);
    }

    function isBlacklisted(address account) public view returns (bool) {
        return blacklist[account];
    }

    // Función de transferencia con validaciones
    function transfer(address to) external notBlacklisted(msg.sender) notBlacklisted(to) {
        require(whitelist[msg.sender], "Sender is not whitelisted");
        require(whitelist[to], "Recipient is not whitelisted");
        // Lógica de transferencia (omitir implementación específica)
    }
}
