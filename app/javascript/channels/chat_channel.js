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
      const emptyMessage = document.querySelector(".chat-empty-message");
      if(emptyMessage)emptyMessage.remove();

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
    
    post(messageData){
      return this.perform("post", {message: messageData["message"]});
    }
  });

  const textArea = document.querySelector(".chat-text-area");
  const imageFile = document.getElementById("image-file");
  chatForm.addEventListener("submit",(e) => {
    const csrfToken = document.getElementsByName("csrf-token")[0].content;
    for(let i = 0;i < imageFile.files.length;i++){
      const url = imageFile.dataset.directUploadUrl;
      const XHR = new XMLHttpRequest();
      XHR.setRequestHeader("csrf-token", csrfToken);
      XHR.open("POST", url);
      XHR.send(imageFile.files[i]);
      XHR.onload = () => {
        if(XHR.status != 200){
          alert(`Error : ${XHR.status} : ${XHR.statusText}`);
          return null;
        }
        console.log(XHR.response);
      }
    }
    app.post({message: textArea.value ,image_id: ""});
    textArea.value = "";
    imageFile.value = "";

    const alreadyPreviews = document.querySelectorAll(".preview");
    if (alreadyPreviews) {
      alreadyPreviews.forEach((alreadyPreview) => {
        alreadyPreview.remove();
      });
    };

    const previewList = document.getElementById("previews");
    previewList.setAttribute("style","display:none");
    e.preventDefault();
  });
});