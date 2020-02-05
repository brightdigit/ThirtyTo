var base32 = require('base32');
var randomstring = require("randomstring");
var assert = require("assert");
var count = 1000;

for (var index = 0; index < count; index++) {
  var string = randomstring.generate();
  var encoded = base32.encode(string);
  var decoded =  base32.decode(encoded);
  assert.equal(decoded, string);
  console.log(string, encoded);
}


