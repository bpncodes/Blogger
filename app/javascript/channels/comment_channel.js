import consumer from "./consumer";

consumer.subscriptions.create("CommentChannel", {
  connected() {
    console.log("Comment channel connected...");
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log(data)
    if (data.type == "add") {
      $("#comments").prepend(data.html);
    }
    if(data.type == "delete"){
      $("#comment-id-"+data.comment.id).remove()
    }
  },
});
