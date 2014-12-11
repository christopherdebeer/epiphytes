
// Copy/pasted/and modified from https://github.com/ccoenraets/phonegap-s3-upload
// Acknoledgements to ccoenraets (http://coenraets.org)

var YOUR_AWS_USER_SECRET = "ZUWmNg0J13Mv/xs2oHqGacKHVRW/BpI/RJ70EdzQ",
    YOUR_AWS_BUCKET_NAME = "wired200";

var crypto = require('crypto'),
    secret = YOUR_AWS_USER_SECRET,
    policy,
    policyBase64,
    signature;

policy = {
    "expiration": "2020-12-31T12:00:00.000Z",
    "conditions": [
        {"bucket": YOUR_AWS_BUCKET_NAME },
        ["starts-with", "$key", ""],
        {"acl": 'public-read'},
        ["starts-with", "$Content-Type", ""],
        ["content-length-range", 0, 524288000]
    ]
};

policyBase64 = new Buffer(JSON.stringify(policy), 'utf8').toString('base64');
console.log("Policy Base64:");
console.log(policyBase64);

signature = crypto.createHmac('sha1', secret).update(policyBase64).digest('base64');
console.log("Signature:");
console.log(signature);