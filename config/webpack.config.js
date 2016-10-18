module.exports = {
  module: {
    entry: './app.js',
    output: {
      optimize: true,
      filename: './bundle.js'
    },
    loaders: [
      {
        test: /\.js?$/,
        exclude: ['/node_modules'],
        loader: 'babel-loader',
        query: {
          presets: ['es2015', 'react']
        }
      },
      {
        test: /\.(scss|css)?$/,
        loader: 'style!css!sass'
      }
    ]
  }
}