const image_preview = () => {
  const chatForm = document.querySelector(".chat-form");
  if(!chatForm)return

  const FILE_NUMBER_LIMIT = gon.file_limit

  const previewList = document.getElementById("previews");
  const fileField = document.querySelector('input[type="file"][name="chat[images][]"]');
  // input要素で値の変化が起きた際に呼び出される関数
  fileField.addEventListener("change", function(e){
    const alreadyPreviews = document.querySelectorAll(".preview");
    if (alreadyPreviews) {
      alreadyPreviews.forEach((alreadyPreview) => {
        alreadyPreview.remove();
      });
    };

    if(e.target.files.length > FILE_NUMBER_LIMIT){
      alert(`一度に投稿できる画像は${FILE_NUMBER_LIMIT}枚までです。`);
      fileField.value = "";
    }

    if(e.target.files.length > 0){
      previewList.removeAttribute("style");
    }else{
      previewList.setAttribute("style","display:none");
      return;
    }

    Array.from(e.target.files).forEach((file) => {
      const blob = window.URL.createObjectURL(file);
      const previewWrapper = document.createElement("div");
      previewWrapper.setAttribute("class", "preview");
      const previewImage = document.createElement("img");
      previewImage.setAttribute("class", "preview-image");
      previewImage.setAttribute("src", blob)

      previewWrapper.appendChild(previewImage);
      previewList.appendChild(previewWrapper);
    });
  });
}

window.addEventListener("turbo:load", image_preview);