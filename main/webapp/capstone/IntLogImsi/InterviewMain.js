let isDropdownOpen = false; // 드롭다운 상태를 추적하는 변수


dropdown = () => {
  var v = document.querySelector('.dropdown-content');
  var dropbtn = document.querySelector('.dropbtn');
  var dropbtn_click = document.querySelector('.dropbtn_click');


  
  // 드롭다운 상태에 따라 처리
  if (!isDropdownOpen) {
    v.classList.add('show'); // 드롭다운 열기
    dropbtn.style.borderBottomStyle = 'none';
    const arrow = document.getElementById('dropbtn_click');
    arrow.innerText = '닫기';
    
    var icon = document.getElementById("dropdownIcon");
    if (icon.innerHTML === "arrow_drop_down") {
      icon.innerHTML = "arrow_drop_up";
    } else {
      icon.innerHTML = "arrow_drop_down";
    }
    
  } else {
    v.classList.remove('show'); // 드롭다운 닫기
    dropbtn.style.borderBottom = '2px solid rgb(217, 217, 217)';
    const arrow = document.getElementById('dropbtn_click');
    arrow.innerText = '열기';
    var icon = document.getElementById("dropdownIcon");
    if (icon.innerHTML === "arrow_drop_down") {
      icon.innerHTML = "arrow_drop_up";
    } else {
      icon.innerHTML = "arrow_drop_down";
    }
  }
  
  // 드롭다운 상태 변경
  isDropdownOpen = !isDropdownOpen;
}