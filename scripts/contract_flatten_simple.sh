#!/bin/bash
if [ $1 ]; then
  FLAT_CONTRACT=""
  # flatten contract
  npx hardhat flatten $1 > $1_flat.sol

  # remove all SPDX-License-Identifiers comments
  sed -i .bak 's|^\/\/\ SPDX.*||g' $1_flat.sol
  # remove all File path comments
  sed -i .bak 's|^\/\/\ File.*||g' $1_flat.sol
  # remove all solidity versions
  sed -i .bak '{/pragma\ solidity/d;}' $1_flat.sol
  # remove all abicoder versions
  sed -i .bak '{/pragma\ abicoder/d;}' $1_flat.sol
  #sed -i .bak 's/^/pragma abicoder v2\; /' $1_flat.sol

  # remove the first 3 lines
  sed -i .bak '1,3d' $1_flat.sol
  # ???
  sed -i .bak '$d' $1_flat.sol
  #add  abicoder to first line
  sed -i .bak '1s/^/pragma abicoder v2;/' $1_flat.sol

else
 echo "need a contract to flatten"
fi

echo "remove .bak files created in contracts folder"
find contracts -name "*.bak" -delete
exit 0