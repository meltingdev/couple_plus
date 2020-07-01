import * as functions from 'firebase-functions';
import admin = require('firebase-admin');

admin.initializeApp();
const db = admin.firestore();
const fcm = admin.messaging();


exports.scheduledFunctionSunday =
  functions.pubsub.schedule('59 23 * * 0').onRun(async (context) => {
    console.log('This will be run every day at 00:00 AM UTC!');
    (await db.collection("Rooms").get().then()).forEach(async document => {
      const roomData = await (await db.collection("Rooms").doc(document.id).get()).data()!;
      console.log(document.id);
      db.collection("Rooms").doc(document.id).update({
        "user1Gem": roomData.user1Gem + 2,
        "user2Gem": roomData.user2Gem + 2,
        "love": 5,
        "totalLove": roomData.totalLove !== NaN ? roomData.totalLove + roomData.love : 0,
        "days": roomData.days !== NaN || roomData.days !== NaN ? roomData.days + 1 : 1,
        "sunday": roomData.love,
      }).then().catch();
    })
    return;
  });

exports.scheduledFunctionMonday =
  functions.pubsub.schedule('59 23 * * 1').onRun(async (context) => {
    console.log('This will be run every day at 00:00 AM UTC!');
    (await db.collection("Rooms").get().then()).forEach(async document => {
      const roomData = await (await db.collection("Rooms").doc(document.id).get()).data()!;
      console.log(document.id);
      db.collection("Rooms").doc(document.id).update({
        "user1Gem": roomData.user1Gem + 2,
        "user2Gem": roomData.user2Gem + 2,
        "love": 5,
        "totalLove": roomData.totalLove !== NaN ? roomData.totalLove + roomData.love : 0,
        "days": roomData.days !== NaN || roomData.days !== NaN ? roomData.days + 1 : 1,
        "monday": roomData.love,
      }).then().catch();
    })
    return;
  });

exports.scheduledFunctionTuesday =
  functions.pubsub.schedule('59 23 * * 2').onRun(async (context) => {
    console.log('This will be run every day at 00:00 AM UTC!');
    (await db.collection("Rooms").get().then()).forEach(async document => {
      const roomData = await (await db.collection("Rooms").doc(document.id).get()).data()!;
      console.log(document.id);
      db.collection("Rooms").doc(document.id).update({
        "user1Gem": roomData.user1Gem + 2,
        "user2Gem": roomData.user2Gem + 2,
        "love": 5,
        "totalLove": roomData.totalLove !== NaN ? roomData.totalLove + roomData.love : 0,
        "days": roomData.days !== NaN || roomData.days !== NaN ? roomData.days + 1 : 1,
        "tuesday": roomData.love,
      }).then().catch();
    })
    return;
  });

exports.scheduledFunctionWednesday =
  functions.pubsub.schedule('59 23 * * 3').onRun(async (context) => {
    console.log('This will be run every day at 00:00 AM UTC!');
    (await db.collection("Rooms").get().then()).forEach(async document => {
      const roomData = await (await db.collection("Rooms").doc(document.id).get()).data()!;
      console.log(document.id);
      db.collection("Rooms").doc(document.id).update({
        "user1Gem": roomData.user1Gem + 2,
        "user2Gem": roomData.user2Gem + 2,
        "love": 5,
        "totalLove": roomData.totalLove !== NaN ? roomData.totalLove + roomData.love : 0,
        "days": roomData.days !== NaN || roomData.days !== NaN ? roomData.days + 1 : 1,
        "wednesday": roomData.love,
      }).then().catch();
    })
    return;
  });

exports.scheduledFunctionThursday =
  functions.pubsub.schedule('59 23 * * 4').onRun(async (context) => {
    console.log('This will be run every day at 00:00 AM UTC!');
    (await db.collection("Rooms").get().then()).forEach(async document => {
      const roomData = await (await db.collection("Rooms").doc(document.id).get()).data()!;
      console.log(document.id);
      db.collection("Rooms").doc(document.id).update({
        "user1Gem": roomData.user1Gem + 2,
        "user2Gem": roomData.user2Gem + 2,
        "love": 5,
        "totalLove": roomData.totalLove !== NaN ? roomData.totalLove + roomData.love : 0,
        "days": roomData.days !== NaN || roomData.days !== NaN ? roomData.days + 1 : 1,
        "thursday": roomData.love,
      }).then().catch();
    })
    return;
  });

exports.scheduledFunctionFriday =
  functions.pubsub.schedule('59 23 * * 5').onRun(async (context) => {
    console.log('This will be run every day at 00:00 AM UTC!');
    (await db.collection("Rooms").get().then()).forEach(async document => {
      const roomData = await (await db.collection("Rooms").doc(document.id).get()).data()!;
      console.log(document.id);
      db.collection("Rooms").doc(document.id).update({
        "user1Gem": roomData.user1Gem + 2,
        "user2Gem": roomData.user2Gem + 2,
        "love": 5,
        "totalLove": roomData.totalLove !== NaN ? roomData.totalLove + roomData.love : 0,
        "days": roomData.days !== NaN || roomData.days !== NaN ? roomData.days + 1 : 1,
        "friday": roomData.love,
      }).then().catch();
    })
    return;
  });

exports.scheduledFunctionSaturday =
  functions.pubsub.schedule('59 23 * * 6').onRun(async (context) => {
    console.log('This will be run every day at 00:00 AM UTC!');
    (await db.collection("Rooms").get().then()).forEach(async document => {
      const roomData = await (await db.collection("Rooms").doc(document.id).get()).data()!;
      console.log(document.id);
      db.collection("Rooms").doc(document.id).update({
        "user1Gem": roomData.user1Gem + 2,
        "user2Gem": roomData.user2Gem + 2,
        "love": 5,
        "totalLove": roomData.totalLove !== NaN ? roomData.totalLove + roomData.love : 0,
        "days": roomData.days !== NaN || roomData.days !== NaN ? roomData.days + 1 : 1,
        "saturday": roomData.love,
      }).then().catch();
    })
    return;
  });



export const newMessageNotif = functions.firestore
  .document("Rooms/{roomRef}/Chat/{desireRef}")
  .onCreate(async (snapshot, context) => {
    // @ts-ignore
    const data = snapshot.data()!;
    const reference = data.desireReference;
    const roomRef = context.params.roomRef
    const sender = data.sender
    let receiver;
    const privateRoomData = (await db.collection("Rooms").doc(roomRef).get()).data()!;

    console.log("Step 1:", reference, sender, roomRef);
    if (sender === privateRoomData.user1) {
      receiver = privateRoomData.user2Email;
    } else {
      receiver = privateRoomData.user1Email;
    }


    console.log("Step 2:", sender, receiver);
    const querySnapshot = (await db
      .collection('Users')
      .doc(receiver)
      .collection('Tokens')
      .doc("token")
      .get()).data()!;

    const tokens = querySnapshot.token;
    console.log("Step 3:", tokens, receiver);
    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title: `${data.sender} has set a new Message`,
        body: "Go check it in the App",
        icon: 'your-icon-url',
        click_action: 'FLUTTER_NOTIFICATION_CLICK'
      }
    };
    return fcm.sendToDevice(tokens, payload);
  })

export const newDesireNotif = functions.firestore
  .document("Rooms/{roomRef}/Desires/{desireRef}")
  .onCreate(async (snapshot, context) => {
    // @ts-ignore
    const data = snapshot.data()!;
    const reference = data.desireReference;
    const roomRef = context.params.roomRef
    const sender = data.sender
    let receiver;
    const privateRoomData = (await db.collection("Rooms").doc(roomRef).get()).data()!;

    console.log("Step 1:", reference, sender, roomRef);
    if (sender === privateRoomData.user1) {
      receiver = privateRoomData.user2Email;
    } else {
      receiver = privateRoomData.user1Email;
    }


    console.log("Step 2:", sender, receiver);
    const querySnapshot = (await db
      .collection('Users')
      .doc(receiver)
      .collection('Tokens')
      .doc("token")
      .get()).data()!;

    const tokens = querySnapshot.token;
    console.log("Step 3:", tokens, receiver);
    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title: `${data.sender} has set a new Desire`,
        body: "Go check it in the App",
        icon: 'your-icon-url',
        click_action: 'FLUTTER_NOTIFICATION_CLICK'
      }
    };
    return fcm.sendToDevice(tokens, payload);
  })

export const newServiceNotif = functions.firestore
  .document("Rooms/{roomRef}/Services/{desireRef}")
  .onCreate(async (snapshot, context) => {
    // @ts-ignore
    const data = snapshot.data()!;
    const reference = data.serviceReference;
    const roomRef = context.params.roomRef
    const sender = data.sender
    let receiver;
    const privateRoomData = (await db.collection("Rooms").doc(roomRef).get()).data()!;

    console.log("Step 1:", reference, sender, roomRef);
    if (sender === privateRoomData.user1) {
      receiver = privateRoomData.user2Email;
    } else {
      receiver = privateRoomData.user1Email;
    }


    console.log("Step 2:", sender, receiver);
    const querySnapshot = (await db
      .collection('Users')
      .doc(receiver)
      .collection('Tokens')
      .doc("token")
      .get()).data()!;

    const tokens = querySnapshot.token;
    console.log("Step 3:", tokens, receiver);
    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title: `${data.sender} has set a new Service`,
        body: "Go check it in the App",
        icon: 'your-icon-url',
        click_action: 'FLUTTER_NOTIFICATION_CLICK'
      }
    };
    return fcm.sendToDevice(tokens, payload);
  })

export const newGalleryNotif = functions.firestore
  .document("Rooms/{roomRef}/Souvenirs/{desireRef}")
  .onCreate(async (snapshot, context) => {
    // @ts-ignore
    const data = snapshot.data()!;
    const reference = data.souvenirReference;
    const roomRef = context.params.roomRef
    const sender = data.sender
    let receiver;
    const privateRoomData = (await db.collection("Rooms").doc(roomRef).get()).data()!;

    console.log("Step 1:", reference, sender, roomRef);
    if (data.sender === privateRoomData.user1) {
      receiver = privateRoomData.user2Email;
    } else {
      receiver = privateRoomData.user1Email;
    }


    console.log("Step 2:", sender, receiver);
    const querySnapshot = (await db
      .collection('Users')
      .doc(receiver)
      .collection('Tokens')
      .doc("token")
      .get()).data()!;

    const tokens = querySnapshot.token;
    console.log("Step 3:", tokens, receiver);
    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title: `${data.sender} has add a new Souvenirs`,
        body: "Go check it in the App",
        icon: 'your-icon-url',
        click_action: 'FLUTTER_NOTIFICATION_CLICK'
      }
    };
    return fcm.sendToDevice(tokens, payload);
  })
