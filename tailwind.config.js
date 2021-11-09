/* eslint-disable no-undef */
module.exports = {
  theme: {
    extend: {
      colors: {
        'nexcar-green': '#20C6B6',
        'nexcar-dark-green': '#10A697',
        'nexcar-light-green': '#C5F9F4',
        'nexcar-second-light-green': '#E7FFFD',
        'nexcar-green-200': '#F3FFFE',
        'nexcar-black': '#333333',
        'background': '#E5E5E5',
      },
      fontFamily: {
        'main': ['Poppins', 'sans-serif'],
      },
      fontSize: {
        'xxs': '.625rem',
      },
    },
  },
  variants: {
    extend: {
      margin: ['responsive', 'last'],
    },
  },
  plugins: [],
  purge: {
    enabled: process.env.NODE_ENV === 'production',
    content: [
      './app/**/*.html',
      './app/**/*.vue',
      './app/**/*.js',
      './app/**/*.erb',
    ],
  },
};
