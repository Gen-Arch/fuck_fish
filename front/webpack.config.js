const VueLoaderPlugin = require('vue-loader/lib/plugin');
module.exports = {
  entry: './src/index.js',
  mode: 'development',
  output: {
    filename: 'bundle.js',
    path: __dirname + '/../public/js',
    publicPath: '/assets/'
  },
  devServer: {
    contentBase: 'public',
    compress: true,
    port: 8080,
    open: false,
  },
  module: {
    rules: [
      {
        test: /\.vue$/,
        loader: 'vue-loader'
      },
      {
        test: /\.(scss|css)$/,
        use: [
          'style-loader',
          'css-loader',
          'sass-loader'
        ]
      },
      {
        test:/\.(JPG|JPEG|jpg)$/,
        loader:'url-loader'
      }
    ],
  },
  resolve: {
    alias: {
      'vue$': 'vue/dist/vue.esm.js'
    },
    extensions: ['.js', '.vue'],
  },

  plugins: [new VueLoaderPlugin()]
};
