import consumer from "channels/consumer"

window.addEventListener("turbo:load",() => {
  const chatForm = document.querySelector(".chat-form");
  if(!chatForm)return;

  const chatMain = document.querySelector(".chat-main");
  const data = chatMain.dataset;
  const userId = data.userId;
  const roomId = data.roomId;
  const userIdentifier = `"user_id":"${userId}"`;
  const subscriptions = consumer.subscriptions.subscriptions;

  if(subscriptions){
    subscriptions.map(function userUnsubscribe(subscription){
      if(subscription.identifier.includes(userIdentifier)){
        subscription.consumer.subscriptions.remove(subscription)
      };
    });
  };

  const app = consumer.subscriptions.create(
    {
      channel: "ChatChannel", room_id: roomId, user_id: userId
    },
    {
    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      return alert(data["message"]);
    },
    
    post(message){
      return this.perform("post", {message: message});
    }
  });

  const textArea = document.querySelector(".chat-text-area");
  chatForm.addEventListener("submit",(e) => {
    app.post(textArea.value);
    textArea.value = "";
    e.preventDefault();
  });
});