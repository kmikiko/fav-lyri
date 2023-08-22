const path = require('path');

module.exports = {
  resolve: {
    alias: {
      tailwindConfig: path.resolve(__dirname, 'tailwind.config.js'),
    },
  },
  module: {
    rules: [
      {
        test: /\.(scss|css)$/,
        use: [
          MiniCssExtractPlugin.loader,
          {
            loader: "css-loader",
            options: {
              importLoaders: 1,
            },
          },
          {
            loader: "postcss-loader",
            options: {
              postcssOptions: {
                plugins: {
                  autoprefixer: {},
                  cssnano: {},
                  // postcss-merge-longhand: {},
                },
              },
            },
          },
          "sass-loader",
        ],
      },
    ],
  },
  performance: { hints: false }
};