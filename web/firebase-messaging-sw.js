// Scripts for firebase and firebase messaging
importScripts("https://www.gstatic.com/firebasejs/8.2.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.2.0/firebase-messaging.js");

// Initialize the Firebase app in the service worker by passing the generated config
const firebaseConfig = {
  
  apiKey: "AIzaSyDKFFTbmaRWUQZowARirHYS0p8HzKhxz60",
  authDomain: "sarf-70217.firebaseapp.com",
  projectId: "sarf-70217",
  storageBucket: "sarf-70217.appspot.com",
  messagingSenderId: "651573448048",
  appId: "1:651573448048:web:87803a6dfc19537f1c13b5",
  measurementId: "G-0CTREGF5QN"
};

firebase.initializeApp(firebaseConfig);

// Retrieve firebase messaging
const messaging = firebase.messaging();

messaging.onBackgroundMessage(function(payload) {
  console.log("Received background message ", payload);

  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});