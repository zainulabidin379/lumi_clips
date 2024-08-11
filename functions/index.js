
const functions = require('firebase-functions');
const admin = require('firebase-admin');
const { Timestamp } = require('firebase-admin/firestore');
admin.initializeApp();



// On User Registration
exports.onUserRegistration = functions.firestore
    .document("users/{id}")
    .onCreate(async (snapshot) => {
        // user details.
        const user = snapshot.data();

        var query = await admin.firestore().collection('clips').orderBy("priority").get();

        let currentTime = new Date();
        const docs = query.docs;

        for (let i = 0; i < docs.length; i++) {
            const doc = docs[i].data();

            // Schedule the notification with the current time
            await admin.firestore().collection(`notifications`).add({
                "title": doc.title.toString(),
                "body": doc.body.toString(),
                "payload": doc.url.toString(),
                "token": user.token.toString(),
                "timestamp": currentTime
            });
            currentTime.setMinutes(currentTime.getMinutes() + doc.nextDelay);
        }
    });


// Send Notifications That are Scheduled
exports.sendScheduledNotifications = functions.pubsub.schedule('* * * * *').onRun(async (context) => {

    const query = await admin.firestore().collection("notifications")
        .where("timestamp", '<=', admin.firestore.Timestamp.now()).get();

    query.forEach(async snapshot => {
        // Notification details.
        const doc = snapshot.data();

        const message = {
            token: doc.token.toString(),
            notification: {
                title: doc.title.toString(),
                body: doc.body.toString(),
            },
            data: {
                payload: doc.payload.toString()
            },
            android: {
                notification: {
                    sound: 'default'
                },
            },
            apns: {
                headers: {
                    "apns-priority": "10"
                },
                payload: {
                    aps: {
                        sound: 'default',
                        category: "NEW_MESSAGE_CATEGORY"
                    }
                }
            }
        };

        await admin
            .messaging()
            .send(message)
            .then((response) => {
                console.log("Notification Sent");
                console.log(response.toString());
            })
            .catch((error) => {
                console.log("Notification Error");
                console.log(error.toString());
            });

        await admin.firestore().collection("notifications").doc(snapshot.id).delete();
    });
});