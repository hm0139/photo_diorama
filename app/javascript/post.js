const chat_post = () => {
  const chatForm = document.querySelector(".chat-form");
  if(!chatForm)return;

  chatForm.addEventListener("submit",(e) => {
    e.preventDefault();
    const formData = new FormData(chatForm);
    const XHR = new XMLHttpRequest();
    XHR.open("POST", location.pathname.replace(/dealings\/\d/, "chats"));
    XHR.send(formData);
    XHR.onload = () => {
      if(XHR.status != 200){
        alert(`Error : ${XHR.status} : ${XHR.statusText}`);
        return null;
      }

      const emptyMessage = document.querySelector(".chat-empty-message");
      if(emptyMessage)emptyMessage.remove();

      const postArea = document.querySelector(".chat-main");
      postArea.insertAdjacentHTML("beforeend", XHR.response);
      const text = document.querySelector(".chat-text-area");
      text.value = "";
      const file = document.querySelector('input[type="file"][name="chat[images][]"]');
      file.value = "";
      const previewList = document.getElementById("previews");
      const alreadyPreviews = document.querySelectorAll(".preview");
      if (alreadyPreviews) {
      alreadyPreviews.forEach((alreadyPreview) => {
        alreadyPreview.remove();
      });
      previewList.setAttribute("style","display:none");
      autoScroll();
    };
    }
  });  
}

function autoScroll(){
  const chats = document.querySelector(".chat-main");
  const lastChat = chats.lastElementChild;
  lastChat.scrollIntoView({
    behavior: "smooth"
  })
}

window.addEventListener("turbo:load", chat_post);