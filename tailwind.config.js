const { resolveConfig } = require('tailwindcss/resolveConfig');
const tailwindConfig = require('./tailwind.config.js');
const fullConfig = resolveConfig(tailwindConfig);

module.exports = {
  purge: {
    enabled: true,
    content: [
      './public/*.html',
      './app/helpers/**/*.rb',
      './app/javascript/**/*.js',
      './app/views/**/*.erb'
    ],
  },
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...fullConfig.theme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}