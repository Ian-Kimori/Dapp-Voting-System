module.exports = {
    networks: {
        development: {
            host: "127.0.0.1",
            port: 8545,  // Make sure this matches Ganache's port
            network_id: "*",  // Accept any network ID to avoid mismatches
        },
    },
    compilers: {
        solc: {
            version: "0.8.19",
        },
    },
};
