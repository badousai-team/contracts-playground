const Big = require('big.js')

module.exports.WEI = new Big(10).pow(18)
module.exports.GAS_LIMIT = 345577
module.exports.GAS_PRICE = new Big(10).pow(10).toFixed(0)
