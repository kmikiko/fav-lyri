const defaultTheme = require('tailwindcss/defaultTheme');
const postcssMergeLonghand = require('postcss-merge-longhand');

module.exports = {
  plugins: [
    require('tailwindcss')({
      theme: {
        extend: {
          fontFamily: {
            sans: ['Inter var', ...defaultTheme.fontFamily.sans],
          },
        },
      },
    }),
    require('autoprefixer'),
    require('postcss-import'),
    require('postcss-flexbugs-fixes'),
    postcssMergeLonghand().disable(), // ここに追加する
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009',
      },
      stage: 3,
    }),
  ],
};