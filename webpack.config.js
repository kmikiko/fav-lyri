const path = require('path');

module.exports = {
  resolve: {
    alias: {
      tailwindConfig: path.resolve(__dirname, 'tailwind.config.js'),
    },
  },
};