function emailAuthentication() {
    const userEmail = document.querySelector("input[name='userEmail']").value;
    fetch(`/confirmEmail.four?userEmail=${userEmail}`)
        .then(response => response.text())
        .then(data => {
            if (data === "success") {
                alert("인증 코드가 발송되었습니다. 이메일을 확인하세요.");
            } else {
                alert("이메일 발송에 실패했습니다. 다시 시도해주세요.");
            }
        })
        .catch(err => console.error(err));
}

function authCodeCheck() {
    const authCode = document.querySelector("input[name='authCode']").value;
    fetch("/authCodeCheck.four", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: `authCode=${authCode}`
    })
        .then(response => response.text())
        .then(data => {
            if (data === "success") {
                alert("인증이 완료되었습니다.");
            } else {
                alert("인증 코드가 일치하지 않습니다.");
            }
        })
        .catch(err => console.error(err));
}