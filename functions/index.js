
const functions = require('firebase-functions');
const admin = require('firebase-admin');
const twilio = require("twilio");
admin.initializeApp();

const accountSid = "ACfc4dc5efb68760a40dfca492166ae4ce";
const authToken = "d751f965b88a90fe35bd521e9c44e944";
const twilioClient = twilio(accountSid, authToken);

// // On User Registration
exports.onUserRegistration = functions.firestore
    .document("users/{phone}")
    .onCreate(async (snapshot) => {
        // user details.
        const user = snapshot.data();

        var query = await admin.firestore().collection('messages').orderBy("no").get();
        const docs = query.docs;

        for (let i = 0; i < docs.length; i++) {
            const doc = docs[i].data();
            const sendAt = new Date(new Date().getTime() + (doc.delay * 60000)).toISOString();

            scheduleSMS(doc.body.toString(), user.phone.toString(), sendAt);
        }
    });

const scheduleSMS = (message, to, sendAt) => {
    twilioClient.messages
        .create({
            body: message,
            messagingServiceSid: "MG3b6fa478cba42774ffc125e6288ac31f",
            from: "+14242091800",
            to: to,
            scheduleType: 'fixed',
            sendAt: sendAt,
        })
        .then((message) => console.log(`Scheduled message with SID: ${message.sid}`))
        .catch((error) => console.error('Error scheduling SMS:', error));
};