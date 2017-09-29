function test() {
    console.log("Hello World!")

    var xhr = new XMLHttpRequest();
    //var data = new FormData();
    //data.append('cont', JSON.stringify(cont));
    //data.append('op', op);
    xhr.open('GET', "http://localhost:8080/devices" , true);
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            console.log(xhr.response);
            var e = document.getElementById("result");
            e.innerHTML=xhr.response;
        }
    }
    xhr.onload = function (data) {
        console.log(data);
    };
    xhr.send();

}
