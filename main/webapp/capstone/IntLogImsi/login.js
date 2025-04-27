function clearInput() {
    var el = document.getElementsByClassName('input-text');

    for(var i = 0; i < el.length; i++){
        el[i].value = "";
    }
}

function clearPass() {
    var el = document.getElementsByClassName('input-pass');

    for(var i = 0; i < el.length; i++){
        el[i].value = "";
    }
}