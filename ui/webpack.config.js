const path = require('path')
const MiniCssExtractPlugin = require('mini-css-extract-plugin')
const WebpackAssetsManifest = require('webpack-assets-manifest')
const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin
const CompressionPlugin = require("compression-webpack-plugin")
const CopyPlugin = require('copy-webpack-plugin')
const { VueLoaderPlugin } = require('vue-loader')
const { CleanWebpackPlugin } = require('clean-webpack-plugin')

module.exports = (env = {}) => ({
  mode: env.production ? 'production' : 'development',
  output: {
    path: path.resolve(__dirname, './dist'),
    filename: '[name]-[fullhash].js',
    publicPath: '',
  },
  module: {
    rules: [
      {
        test: /\.vue$/,
        use: [
          {
            loader: 'vue-loader',
          }
        ]
      },
      {
        test: /\.ts$/,
        use: [
          {
            loader: 'ts-loader',
            options: {
              appendTsSuffixTo: [/\.vue$/]
            }
          }
        ]
      },
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel-loader'
      },
      {
        test: /\.css$/,
        use: [
          MiniCssExtractPlugin.loader,
          'css-loader',
          'postcss-loader',
          'sass-loader',
        ]
      },
      {
        test: /\.scss$/,
        use: [
          MiniCssExtractPlugin.loader,
          'css-loader',
          'postcss-loader',
          'sass-loader',
        ]
      },
      {
        test: /\.(woff(2)?|ttf|eot|svg)(\?v=\d+\.\d+\.\d+)?$/,
        use: [
          {
            loader: 'file-loader',
            options: {
              name: '[name].[ext]',
              outputPath: 'fonts/'
            }
          }
        ]
      },
      {
        test: /\.(png|jpe?g|gif)$/i,
        use: [
          {
            loader: 'file-loader',
            options: {
              name: '[name].[ext]',
              outputPath: 'fonts/'
            }
          },
        ],
      }
    ],
  },
  resolve: {
    modules: [
      path.resolve(__dirname, './src'),
      path.resolve(__dirname, './node_modules')
    ],
    extensions: ['.js', '.ts', '.vue', '.json', '.less' , '.scss', '.css']
  },
  plugins: [
    new CopyPlugin({
      patterns: [
        {
          from: path.resolve(__dirname, './node_modules/@tabler/icons/icons'),
          to: path.resolve(__dirname, './dist/icons')
        }
      ]
    }),
    new MiniCssExtractPlugin({
      filename: '[name]-[fullhash].css'
    }),
    new WebpackAssetsManifest({
      writeToDisk: true,
      output: 'manifest.json',
      publicPath: true
    }),
    new VueLoaderPlugin(),
    env.production && new CleanWebpackPlugin(),
    (env.production || env.test) && new CompressionPlugin({ test: /\.(js|css|svg)(\?.*)?$/i }),
    process.env.BUNDLE_ANALYZE && new BundleAnalyzerPlugin()
  ].filter(Boolean),
  devServer: {
    port: 9090,
    contentBase: './',
    hot: false,
    stats: 'minimal',
    injectClient: false,
    overlay: {
      warnings: true,
      errors: true
    },
    historyApiFallback: true
  }
})
