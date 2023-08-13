const { resolveConfig } = require('tailwindcss/resolveConfig');
const tailwindConfig = require('./tailwind.config.js');
const fullConfig = resolveConfig(tailwindConfig);

module.exports = {
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...fullConfig.theme.fontFamily.sans],
      },
    },
  },
  purge: {
    enabled: true,
    content: [
      './public/*.html',
      './app/helpers/**/*.rb',
      './app/javascript/**/*.js',
      './app/views/**/*.{erb,haml,html,slim}'
    ],
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
    require('postcss-merge-longhand').disable(),
  ]
}