module.exports = {
    networks: {
        development: {
            host: "localhost",
            port: 8545,
            network_id: "*" // Match any network id
        },
        vertex: {
            host: "51.255.71.233",
            port: "30303",

        },
        live: {
            host: "localhost",
            port: 8546,
            network_id: "1"
        }
    }
};
