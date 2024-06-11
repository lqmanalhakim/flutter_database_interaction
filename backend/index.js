const express = require('express');
const bodyParser = require('body-parser');
const oracledb = require('oracledb');
const dotenv = require('dotenv');

dotenv.config();

const app = express();
app.use(bodyParser.json());

// Oracle DB connection
async function initialize() {
    oracledb.createPool({
        user: 'GPDATA',
        password: 'GPDATA',
        connectString: 'DESKTOP-GSIHUG7:1521/XE'
    });
}

app.post('/donors', async (req, res) => {
    const { DonorID, Name, ContactInfo, Address, DonationTotal } = req.body;
    try {
        const connection = await oracledb.getConnection();
        await connection.execute(
            `INSERT INTO Donor (DonorID, Name, ContactInfo, Address, DonationTotal)
             VALUES (:DonorID, :Name, :ContactInfo, :Address, :DonationTotal)`,
            { DonorID, Name, ContactInfo, Address, DonationTotal },
            { autoCommit: true }
        );
        res.status(201).send('Donor added successfully');
    } catch (err) {
        res.status(500).send(err.message);
    }
});

// Add more routes as needed

initialize().then(() => {
    app.listen(3000, () => {
        console.log('Server is running on port 3000');
    });
}).catch(err => {
    console.error('Error initializing database connection: ', err);
});
