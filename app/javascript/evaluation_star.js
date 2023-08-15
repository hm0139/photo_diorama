function inputEvaluation(){
  const starContainer = document.querySelector(".stars-container");
  if(!starContainer)return;

  const rankNum = document.getElementById("rank-num");
  const stars = document.getElementsByClassName("star");
  for(let i = 0;i < stars.length;i++){
    stars[i].addEventListener("click",() => {
      const lightOn = "star-bg-on";
      const lightOff = "star-bg-off";
      for(let j = 0;j < stars.length;j++){
        stars[j].className = "star " + lightOff;
      }
      for(let j = 0;j <= i;j++){
        stars[j].className = "star " + lightOn;
      }
      rankNum.value = i + 1;
    });
  }
}

window.addEventListener("turbo:load", inputEvaluation);