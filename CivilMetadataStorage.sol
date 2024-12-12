
// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;


contract CivilMetadataStorage {
    // Define the metadata struct
    struct CivilDocument {
        string ipfsHash; // IPFS CID
        string encryptedMetadata; // Encrypted document data
    }

    // Mapping from document ID (or address) to CivilDocument metadata
    mapping(string => CivilDocument)  documents;

    // Function to store metadata
    function storeDocument(
        string memory _documentId,
        string memory _ipfsHash,
        string memory _encryptedMetadata
      
    ) public {
        documents[_documentId] = CivilDocument(_ipfsHash, _encryptedMetadata);

    }

    // Function to retrieve document metadata by document ID
    function getDocument(string memory _documentId) public view returns (
        string memory, string memory
    ) {
        CivilDocument memory doc = documents[_documentId];
        return (doc.ipfsHash, doc.encryptedMetadata);
    }
}