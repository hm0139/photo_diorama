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
      const message = data["message"];
      const json = JSON.parse(message);
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `${location.pathname.replace(/dealings\/\d+/,"dealings/make")}?id=${json.id}`);
      XHR.send(json);
      XHR.onload = () => {
        if(XHR.status != 200){
          alert(`Error : ${XHR.status} : ${XHR.statusText}`);
          return null;
        }
        chatMain.insertAdjacentHTML("beforeend", XHR.response);
        const mainRect = chatMain.getBoundingClientRect();
        const last = chatMain.lastElementChild;
        const lastRect =last.getBoundingClientRect();
        const targetTop = lastRect.top - mainRect.top
        chatMain.scrollBy({top: targetTop, behavior: "smooth"});
      }
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