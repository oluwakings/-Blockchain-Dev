const express = require('express');
const axios = require('axios');
const cloudinary = require('cloudinary').v2; // Make sure to use cloudinary.v2
const edeSolomonRoutes = require('./routes/edehSolomonRoutes'); // Adjust path as needed
const PORT = process.env.PORT || 3099;

// Setup cloudinary configuration
cloudinary.config({
  cloud_name: process.env.CLOUDINARY_NAME,
  api_key: process.env.CLOUDINARY_API_KEY,
  api_secret: process.env.CLOUDINARY_API_SECRET,
});

module.exports = cloudinary;

// Endpoint to fetch smart contract data
router.get('/edehsolomon/apitest', async (req, res) => {
  try {
    const { contractAddress } = req.query;

    if (!contractAddress) {
      return res.status(400).json({ error: 'Contract address is required' });
    }

    // Fetch smart contract details from a blockchain API
    const response = await axios.get(blockchainApiUrl, {
      params: {
        module: 'contract',
        action: 'getsourcecode',
        address: contractAddress,
        apiKey: process.env.BLOCKCHAIN_API_KEY,
      },
    });
    res.json({
      message: 'Smart contract data fetched and uploaded successfully',
      contractData,
      cloudinaryUrl: uploadResponse.secure_url,
    });
  } catch (error) {
    // Log and handle any errors
    console.error(error);
    res.status(500).json({ error: 'Something went wrong' });
  }
});

// Create the express app
const app = express();

// Middleware to parse JSON bodies
app.use(express.json());

// Register your routes `
app.use('/api', edeSolomonRoutes);

const server = app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);

// Blockchain API URL
const blockchainApiUrl = 'https://api.etherscan.io/api'; // Example: Etherscan

// Route to fetch smart contract data and upload to Cloudinary
app.get('/edehsolomon/apitest', async (req, res) => {
  try {
    const { contractAddress } = req.query;

    // Ensure contract address is provided
    if (!contractAddress) {
      return res.status(400).json({ error: 'Contract address is required' });
    }

    // Fetch contract details from the blockchain API (Etherscan example)
    const response = await axios.get(blockchainApiUrl, {
      params: {
        module: 'contract',
        action: 'getsourcecode',
        address: contractAddress,
        apiKey: process.env.BLOCKCHAIN_API_KEY,
      },
    });

    const contractData = response.data.result[0];

    // Upload contract data to Cloudinary
    const uploadResponse = await cloudinary.uploader.upload(
      `data:text/plain;base64,${Buffer.from(JSON.stringify(contractData)).toString('base64')}`,
      {
        resource_type: 'raw',
        public_id: `contracts/${contractAddress}`,
      }
    );

    // Send response with contract data and Cloudinary URL
    res.json({
      message: 'Smart contract data fetched and uploaded successfully',
      contractData,
      cloudinaryUrl: uploadResponse.secure_url,
    });
  } catch (error) {
    // Log and handle any errors
    console.error(error);
    res.status(500).json({ error: 'Something went wrong' });
  }
});


module.exports = router;

// Handling uncaught exceptions globally
process.on("uncaughtException", (err) => {
  console.error(`Uncaught exception: ${err.message}`);
  process.exit(1); // Exit after an uncaught exception
});

// Handling unhandled promise rejections globally
process.on("unhandledRejection", (err) => {
  console.error(`Unhandled promise rejection: ${err.message}`);
  process.exit(1); // Optionally exit after an unhandled rejection
});

// Start the server
const server = app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
})});
