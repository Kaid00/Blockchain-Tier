// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract CivilMetadataStorage {
    struct CivilDocument {
        string ipfsHash;
        string encryptedMetadata;
    }

    mapping(string => CivilDocument) documents;

    function storeDocument(
        string memory _documentId,
        string memory _ipfsHash,
        string memory _encryptedMetadata
    ) public {
        documents[_documentId] = CivilDocument(_ipfsHash, _encryptedMetadata);
    }

    function getDocument(
        string memory _documentId
    ) public view returns (string memory, string memory) {
        CivilDocument memory doc = documents[_documentId];
        return (doc.ipfsHash, doc.encryptedMetadata);
    }
}
