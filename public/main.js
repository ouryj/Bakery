let s1 = document.querySelector("#send");
s1.addEventListener("submit", (event)=>{
    event.preventDefault();

    alert("we have received your request check your inbox for more details");
});