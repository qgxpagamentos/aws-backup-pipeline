const AWS = require("aws-sdk");
const firehouse = new AWS.Firehose({ 'region': process.env.REGION });

const isJson = (str) => {
    try {
        JSON.parse(str);
    } catch (e) {
        return false;
    }
    return true;
};

exports.handler = (event, context) => {
    if (!event.Records) {
        console.log('no records');
        return;
    }
    event.Records.map(async(record) => {
        if (!isJson(record.body)) {
            console.log('no json type');
            return;
        }
        const params = {
            DeliveryStreamName: process.env.DELIVERY_STREAM_NAME,
            Record: {
                Data: JSON.stringify(JSON.parse(record.body)) + '\n'
            }
        };
        firehouse.putRecord(params, (err, data) => {
            if (err) {
                console.log(err, err.stack);
            }
        });
    });
};
