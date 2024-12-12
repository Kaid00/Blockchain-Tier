// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CivilMetadataStorage {
    // Define the metadata struct
    struct CivilDocument {
        string ipfsHash; // IPFS CID
        string encryptedMetadata; // Encrypted document data
    }

    // Mapping from document ID (or address) to CivilDocument metadata
    mapping(string => CivilDocument) public documents;

    // Event emitted when a document is stored
    event DocumentStored(string documentId, string ipfsHash);

    // Function to store metadata
    function storeDocument(
        string memory _documentId,
        string memory _ipfsHash,
        string memory _encryptedMetadata
    ) public {
        documents[_documentId] = CivilDocument(_ipfsHash, _encryptedMetadata);
        emit DocumentStored(_documentId, _ipfsHash); // Emit event for monitoring
    }

    // Function to retrieve document metadata by document ID
    function getDocument(string memory _documentId) public view returns (string memory, string memory) {
        CivilDocument memory doc = documents[_documentId];
        return (doc.ipfsHash, doc.encryptedMetadata);
    }

    // Function to store multiple documents in one transaction (bulk storage)
    function storeMultipleDocuments(
        string[] memory _documentIds,
        string[] memory _ipfsHashes,
        string[] memory _encryptedMetadataArray
    ) public {
        require(
            _documentIds.length == _ipfsHashes.length && _ipfsHashes.length == _encryptedMetadataArray.length,
            "Arrays length mismatch"
        );
        for (uint i = 0; i < _documentIds.length; i++) {
            storeDocument(_documentIds[i], _ipfsHashes[i], _encryptedMetadataArray[i]);
        }
    }

    // Stress test function: store a document multiple times to simulate high load
    function stressTestStoreDocument(
        string memory _documentIdPrefix,
        string memory _ipfsHash,
        string memory _encryptedMetadata,
        uint256 _iterations
    ) public {
        for (uint i = 0; i < _iterations; i++) {
            string memory generatedId = string(abi.encodePacked(_documentIdPrefix, uint2str(i)));
            storeDocument(generatedId, _ipfsHash, _encryptedMetadata);
        }
    }

    // Helper function: convert uint to string
    function uint2str(uint256 _i) internal pure returns (string memory) {
        if (_i == 0) return "0";
        uint256 j = _i;
        uint256 length;
        while (j != 0) {
            length++;
            j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint256 k = length;
        while (_i != 0) {
            k = k - 1;
            bstr[k] = bytes1(uint8(48 + _i % 10));
            _i /= 10;
        }
        return string(bstr);
    }
}
