function inputEvaluation(){
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

function evaluationSubmit(form){
  form.addEventListener("submit",(e) =>{
    const rankNum = document.getElementById("rank-num");
    const rank = parseInt(rankNum.value);
    if(rank < 1 || rank > 5){
      alert("評価は1〜5の範囲で入力してください。");
      e.preventDefault();
      return;
    }
  });
}

window.addEventListener("turbo:load", () => {
  const evaluationForm = document.querySelector(".evaluations-input-form");
  if(!evaluationForm)return;
  inputEvaluation();
  evaluationSubmit(evaluationForm);
});
