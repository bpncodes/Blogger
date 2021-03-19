import consumer from "./consumer"

consumer.subscriptions.create("LikesChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Like channel connected")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log(data)
     $("#like-count").html(data.html);
  }
});
