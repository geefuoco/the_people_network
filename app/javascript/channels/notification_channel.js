import consumer from "./consumer"

consumer.subscriptions.create("NotificationChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const notif = this.badge()
    $("#dropdown-Notifications").append(notif)
    $("#notifications").prepend(data.html)
  },

  badge(){
    return `
      <span class='position-absolute top-0 start-100 translate-middle p-2 bg-danger border border-light rounded-circle'>
      <span class='visually-hidden'>New alerts</span></span>
    `
  }
});
