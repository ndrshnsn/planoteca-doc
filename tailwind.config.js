
const defaultTheme = require('tailwindcss/defaultTheme')
const colors = require('tailwindcss/colors')

module.exports = {
    content: [
      './_drafts/**/*.html',
      './_includes/**/*.html',
      './_layouts/**/*.html',
      './_posts/*.md',
      './*.md',
      './*.html',
    ],
    theme: {
      container: {
        screens: {
          sm: '640px',
          md: '768px',
          lg: '1024px',
          xl: '1320px'
        },
      },
      extend: {
        fontFamily: {
            Lato: ['Lato', ...defaultTheme.fontFamily.sans],
            Merriweather: ['Merriweather', ...defaultTheme.fontFamily.sans]
        },
        colors: {
          'primary':    '#4f7369',
          'secondary':  '#7dbfb3',
          'info':       '#a9f3e6',
          'accent':     '#194659',
          'neutral':    '#ecf2f2',
          'success':    '#66b7af',
          'warning':    '#ffcd38',
          'danger':     '#cc451b'
        },
      },
    },
    plugins: [
      require('@tailwindcss/typography'),
    ]
  }