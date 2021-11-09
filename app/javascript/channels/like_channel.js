import consumer from "./consumer"

consumer.subscriptions.create("LikeChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("connected")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const p_tag = document.getElementById("follow-btn")
    const following_show = document.getElementById("following_show")
    const followers_show = document.getElementById("followers_show")
  
    p_tag.innerHTML = data.text
    followers_show.innerHTML = "Followers: "+data.followers
    following_show.innerHTML = "Following: "+data.following
  }
});
