const finish_confirmation = () => {
  const finish_button = document.getElementById("finish-button");
  console.log(location.pathname);
  console.log(finish_button);
  if(finish_button == null )return;

  const dialog_box = document.getElementById("finish-dialog-box");
  finish_button.addEventListener("click",() => {
    dialog_box.setAttribute("style","display:flex");
  });

  const no_finish_button = document.getElementById("no-finish");
  no_finish_button.addEventListener("click",() => {
    dialog_box.removeAttribute("style");
  });
}

window.addEventListener("turbo:load", finish_confirmation);